#!/bin/bash

CHEFDK_VERSION="0.7.0"
TARGET_DIR="/tmp/vagrant-cache/wget"
REPO_ROOT="/home/vagrant/vm-setup"

# to not run into https://github.com/berkshelf/berkshelf-api/issues/112
echo "setting locale to en_US.UTF-8"
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

big_step() {
  echo ""
  echo "====================================="
  echo ">>>>>> $1"
  echo "====================================="
  echo ""
}

step() {
  echo ""
  echo ""
  echo ">>>>>> $1"
  echo "-------------------------------------"
  echo ""
}

check_chefdk() {
  big_step "Checking ChefDK..."
  if [[ $(chef -v | grep $CHEFDK_VERSION) ]]; then
    echo "ChefDK $CHEFDK_VERSION already installed"
  else
    step "Downloading and installing ChefDK $CHEFDK_VERSION"
    mkdir -p $TARGET_DIR
    wget --no-verbose --no-clobber -O $TARGET_DIR/chefdk_$CHEFDK_VERSION-1_amd64.deb \
      https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/chefdk_$CHEFDK_VERSION-1_amd64.deb
    sudo dpkg -i $TARGET_DIR/chefdk_$CHEFDK_VERSION-1_amd64.deb
  fi
}

check_git() {
  big_step "Checking Git..."
  if [[ $(which git) ]]; then
    echo "Git already installed"
  else
    step "Installing Git"
    sudo apt-get install git -y
  fi
}

copy_repo_and_symlink_self() {
  big_step "Copying repo into the VM..."
  if mountpoint -q /vagrant; then
    step "Copy /vagrant to $REPO_ROOT"
    sudo rm -rf $REPO_ROOT
    cp -r /vagrant $REPO_ROOT
    step "Symlinking 'update-vm' script"
    sudo ln -sf $REPO_ROOT/scripts/update-vm.sh /usr/local/bin/update-vm
  else
    echo "Skipped because /vagrant not mounted"
  fi
}

shell_init() {
  step "init the shell"
  set -e
  eval $(chef shell-init bash)
}

update_repo() {
  big_step "Pulling latest changes from git..."
  cd $REPO_ROOT
  git pull
}

update_vm() {
  big_step "Updating the VM via Chef..."

  shell_init
  cd $REPO_ROOT/cookbooks/vm

  # install cookbook dependencies
  step "install cookbook dependencies"
  rm -rf ./cookbooks
  berks vendor ./cookbooks

  # converge the system via chef-zero
  step "trigger the chef-zero run"
  sudo chef-client --local-mode --format=doc --force-formatter --color --runlist=vm
}

verify_vm() {
  big_step "Verifying the VM..."

  shell_init
  cd $REPO_ROOT/cookbooks/vm

  # run lint checks
  step "run codestyle checks"
  rubocop . --format progress --format offenses --display-cop-names
  foodcritic -f any .

  # run integration tests
  step "run integration tests"
  rspec --require rspec_junit_formatter --format doc --color --format RspecJunitFormatter --out test/junit-report.xml --format html --out test/test-report.html
}

#
# main flow
#
if [[ "$1" == "--verify-only" ]]; then
  verify_vm
else
  check_git
  check_chefdk
  copy_repo_and_symlink_self
  [[ "$1" == "--pull" ]] && update_repo
  update_vm
  verify_vm
fi
