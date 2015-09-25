#!/bin/bash

CHEFDK_VERSION="0.7.0"
TARGET_DIR="/tmp/vagrant-cache/wget"
SCRIPT_FILE="$(readlink -f ${BASH_SOURCE[0]})"
REPO_ROOT="$(dirname $SCRIPT_FILE)/.."

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

symlink_self() {
  big_step "Symlinking 'update-vm'..."
  sudo ln -sf $SCRIPT_FILE /usr/local/bin/update-vm
}

shell_init() {
  step "init the shell"
  set -e
  eval $(chef shell-init bash)
}

update_repo() {
  step "Pulling latest changes from git..."
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
  rubocop . --format progress --format offenses
  foodcritic -f any .

  # run integration tests
  step "run integration tests"
  rspec -fd --color
}

#
# main flow
#
if [[ "$1" == "--verify-only" ]]; then
  verify_vm
else
  check_git
  check_chefdk
  symlink_self
  [[ "$1" == "--pull" ]] && update_repo
  update_vm
  verify_vm
fi
