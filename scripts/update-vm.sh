#!/bin/bash
set -e -o pipefail

CHEFDK_VERSION=3.4.38
DOWNLOAD_DIR=/tmp/vagrant-cache/wget
REPO_ROOT=~/vm-setup

RUN_LIST="stations/full-node.json"
PROVISION_ONLY=false
VERIFY_ONLY=false

POSITIONAL=()
while [[ $# -gt 0 ]]
do
  key="$1"
  case $key in
    --verify-only)
      VERIFY_ONLY=true
      shift # past argument
      ;;
    --provision-only)
      PROVISION_ONLY=true
      shift # past argument
      ;;
    --pull)
      PULL=true
      shift # past argument
      ;;
    *)    # unknown option
      POSITIONAL+=("$1") # save it in an array for later
      shift # past argument
      ;;
  esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

if [[ $# -eq 1 ]]; then
  RUN_LIST="$1"
elif [[ $# -gt 1 ]]; then
  echo "Invalid number of arguments"
  exit 1
fi

main() {
  setup_chefdk
  if [[ "$VERIFY_ONLY" == true ]]; then
    verify_vm
  else
    copy_repo_and_symlink_self
    [[ "$PULL" == true ]] && update_repo
    update_vm
    [[ "$PROVISION_ONLY" == true ]] || verify_vm
  fi
}

setup_chefdk() {
  big_step "Setting up ChefDK..."
  if [[ $(head -n1 /opt/chefdk/version-manifest.txt 2>/dev/null | grep "chefdk $CHEFDK_VERSION") ]]; then
    echo "ChefDK $CHEFDK_VERSION already installed"
  else
    step "Downloading and installing ChefDK $CHEFDK_VERSION"
    curl -L https://omnitruck.chef.io/install.sh | sudo bash -s -- -P chefdk -c stable -v $CHEFDK_VERSION -d /tmp/vagrant-cache
  fi
  # initialize the shell, adding ChefDK binaries to the PATH
  eval "$(chef shell-init bash)"
}

copy_repo_and_symlink_self() {
  big_step "Copying repo into the VM..."
  if mountpoint -q /vagrant; then
    sudo rm -rf $REPO_ROOT
    sudo cp -r /vagrant $REPO_ROOT
    sudo chown -R $USER:$USER $REPO_ROOT
    sudo ln -sf $REPO_ROOT/scripts/update-vm.sh /usr/local/bin/update-vm
    echo "Copied repo to $REPO_ROOT and symlinked the 'update-vm' script"
  else
    echo "Skipped because /vagrant not mounted"
  fi
}

update_vm() {
  big_step "Updating the VM via Chef..."
  cd $REPO_ROOT/cookbooks/vm

  step "install cookbook dependencies"
  berks vendor --delete ./cookbooks

  # disable vmware ohai plugin because it's so painfully slow
  sudo find /opt/chefdk/embedded/ -wholename *ohai* -name vmware.rb -exec mv {} {}.disabled \;

  step "update the system via chef-zero"
  sudo -H chef-client --local-mode \
    --config-option node_path=/root/.chef/nodes \
    --config-option role_path=$REPO_ROOT/roles \
    --format=doc --force-formatter --log_level=warn --color \
    -j $REPO_ROOT/$RUN_LIST
}

verify_vm() {
  big_step "Verifying the VM..."
  cd $REPO_ROOT/cookbooks/vm

  step "run foodcritic linting checks"
  foodcritic -f any .

  step "run serverspec integration tests for $(basename "$RUN_LIST" .json)"
  rspec --require rspec_junit_formatter \
    --format doc --color --tty \
    --format RspecJunitFormatter --out test/junit-report.xml \
    --format html --out test/test-report.html \
    --tag base \
    --tag $(basename "$RUN_LIST" .json)
}

update_repo() {
  big_step "Pulling latest changes from git..."
  cd $REPO_ROOT
  git pull
}

big_step() {
  echo -e "\n=====================================\n>>>>>> $1\n=====================================\n"
}
step() {
  echo -e "\n\n>>>>>> $1\n-------------------------------------\n"
}

# run it!
main
