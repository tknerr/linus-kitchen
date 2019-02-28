
# Linus' Kitchen

[![Build Status](https://travis-ci.com/fasmat/linus-kitchen.svg?branch=customize-installed-applications)](https://travis-ci.com/fasmat/linus-kitchen)

An Ubuntu Desktop 18.04 based development box for Infrastructure-as-Code development with Vagrant, Chef, Ansible & Co.

![Linus' Kitchen Screenshot](https://raw.github.com/tknerr/linus-kitchen/master/linus_kitchen.png)

It is based on the [Zuehlke/linux-developer-vm](https://github.com/Zuehlke/linux-developer-vm) template, and also the Linux based equivalent of [Bill's Kitchen](https://github.com/tknerr/bills-kitchen) (which explains the name).

## What's included

### Main tools

These are the main tools included in Linus' Kitchen (see CHANGELOG for the specific versions):

* [Ansible](https://www.ansible.com/)
* [Atom Editor](http://atom.io/)
* [ChefDK](https://downloads.chef.io/chef-dk/)
* [Docker](http://docker.io/)
* [Git](https://git-scm.org/)
* [Go](https://golang.org/)
* [Packer](http://packer.io/)
* [Vagrant](http://vagrantup.com/)
* [VirtualBox](https://www.virtualbox.org/)
* [VSCode](https://code.visualstudio.com/)

#### Chef-based development toolchain

In addition to Chef itself, the following tools (which are all Ruby-based) come included with ChefDK:

* [berkshelf](https://berkshelf.com/) - a dependency manager for Chef cookbooks
* [foodcritic](http://www.foodcritic.io/) - a lint tool for Chef cookbooks
* [chefspec](https://chefspec.github.io/chefspec/) - unit testing for Chef cookbooks
* [serverspec](http://serverspec.org/) - rspec based framework for testing servers
* [test-kitchen](http://kitchen.ci/) - a test driver for orchestrating and testing infrastructure

#### Ansible-based development toolchain

In addition to Ansible itself, the following tools (which are all Python-based) are included:

* [ansible-galaxy](https://docs.ansible.com/ansible/galaxy.html) - a dependency manager for Ansible roles
* [ansible-lint](https://github.com/willthames/ansible-lint) - a lint tool for Ansible roles
* [testinfra](https://testinfra.readthedocs.io/) - a pytest based framework for testing servers
* [molecule](https://molecule.readthedocs.io/) - a test driver for orchestrating and testing infrastructure

### Tweaks and Plugins

Other tweaks worth mentioning:

* Scripts in `~/.bashrc.d/*.sh` are sourced from `~/.bashrc`, pre-configured with the following:
  * sets up `be` as an alias for `bundle exec`
  * runs `chef shell-init bash` for initializing the ChefDK
  * configures "virtualbox" as the `$VAGRANT_DEFAULT_PROVIDER`
* Bundler is configured for parallel downloading and retrying (see `~/.bundle/config`)
* Customized Atom config, e.g. with SublimeText-like tab behaviour (see `~/.atom/config.cson`)
* Customized `~/.vagrant.d/Vagrantfile` and `~/.kitchen/config.yml` for caching as much as possible
* Pre-installed Vagrant plugins:
  * [vagrant-omnibus](https://github.com/schisamo/vagrant-omnibus) - installs omnibus chef in a vagrant VM
  * [vagrant-cachier](https://github.com/fgrehm/vagrant-cachier) - caches all kinds of packages you install in the vagrant VMs
  * [vagrant-berkshelf](https://github.com/berkshelf/vagrant-berkshelf) - berkshelf integration for vagrant
  * [vagrant-toplevel-cookbooks](https://github.com/tknerr/vagrant-toplevel-cookbooks) - support for one top-level cookbook per vagrant VM
  * [vagrant-managed-servers](https://github.com/tknerr/vagrant-managed-servers) - Vagrant Provider for provisioning managed servers via SSH or     WinRM
  * [vagrant-lxc](https://github.com/fgrehm/vagrant-lxc) - LXC provider for Vagrant
* Pre-installed Atom plugins:
  * [atom-beautify](https://atom.io/packages/atom-beautify) - code formatter / beautifier for various languages
  * [minimap](https://atom.io/packages/minimap) - a SublimeText like minimap
  * [language-chef](https://atom.io/packages/language-chef) - code snippets for Chef recipes
  * [language-ansible](https://atom.io/packages/language-ansible) - code snippets for Ansible roles
* Placed a `README.md` file on the Desktop to guide first time users after they logged in to the VM
* Symlinked [`update-vm.sh`](scripts/update-vm.sh) to `/usr/local/bin/update-vm` so it's in the `$PATH` and can be used for updating the VM from    the inside (see below)

## Usage

### Obtaining and Starting the VM Image

The latest version of the Linus Kitchen can be downloaded as a VM image from here:

* <https://github.com/tknerr/linus-kitchen/releases>

After downloading the .ova file you can import it into VMWare Fusion / Workstation Player via `File -> Import...`.
Once imported, you can simply start the VM and log in:

* username: "user"
* password: "user"

From then on just open a terminal and you will have all of the tools available (see "What's included?").

### Updating the VM

You can run these commands from anywhere inside the VM:

* `update-vm` - update the VM by applying the Chef recipes from the locally checked out repo at `~/vm-setup`
* `update-vm --pull` - same as above, but update repo before by pulling the latest changes
* `update-vm --verify-only` - don't update the VM, only run the Serverspec tests
* `update-vm --provision-only` - don't run the Serverspec tests, only update the vm

### Keyboard Layout and Locale Settings

The VM ships with a full `US` keyboard layout and `en_US.UTF-8` locale by default.

To change the keyboard layout to your preferred language use `System Settings... -> Text Entry` in the VM.

If you have a totally different keymap (e.g. on a MacBook) you can always reconfigure it:

```bash
sudo dpkg-reconfigure keyboard-configuration
```

If want to reconfigure the locale:

```bash
sudo dpkg-reconfigure locales
```

## Development

### Prerequisites

You need [VMware Workstation Pro](https://www.vmware.com/products/workstation.html) / [VMware Fusion Pro](https://www.vmware.com/products/workstation.html) and [Vagrant](http://www.vagrantup.com/) with the [vagrant-vmware-plugin](https://www.vagrantup.com/vmware/) installed.

If you don't mind about running 64-bit VirtualBox VMs inside Linus Kitchen, you only even need [VirtualBox](http://virtualbox.org/wiki/Downloads) and [Vagrant](http://www.vagrantup.com/) installed (note that VirtualBox only supports nested 32-bit guests).

All other requirements, including ChefDK will be installed*inside the Vagrant VM* during provisioning, i.e. you don't need them installed on your host machine.

### Basic Development Workflow

Bring up the developer VM:

```bash
vagrant up
```

This will take a while, as it will do quite a few things inside the VM:

 1. Setup a new user account ('user') under which the VM will be provisioned
 1. Download and install [ChefDK](https://downloads.chef.io/chef-dk/)
 1. Copy the current directory into the VM (will be placed in `~/vm-setup`)
 1. Install cookbook dependencies via [Berkshelf](http://berkshelf.com/) to `~/vm-setup/cookbooks/vm/cookbooks`
 1. Trigger a [Chef-Zero](https://www.chef.io/blog/2013/10/31/chef-client-z-from-zero-to-chef-in-8-5-seconds/) run to apply the `~/vm-setup/cookbooks/vm/recipes` to the VM (see "What's included?")
 1. Verify the installation using a battery of [Serverspec](http://serverspec.org/) tests

Watch the vagrant output on the console for seeing progress. At the end you
should see all tests passing:

```bash
...
==> default:
==> default: update-vm.sh
==> default:   installs chefdk 1.3.40
==> default:   symlinks the update-vm script to /usr/local/bin/
==> default:
==> default: Finished in 26.85 seconds (files took 1.08 seconds to load)
==> default: 59 examples, 0 failures
...
```

If these are passing as expected, you can continue developing on the Chef recipes within this repo.
Please don't forget to add a test for each new feature you add (see "Contributing")

### Running the Acceptance Tests

In addition to the Serverspec tests (which verify that the installed tools are properly configured and working as expected) you can also execute a minimal acceptance test which covers the [common usage scenarios](https://github.com/tknerr/vagrant-workflow-tests/blob/master/spec/acceptance/usage_scenarios_spec.rb) when developing with Vagrant and Chef, including:

* cloning a [sample-toplevel-cookbook](https://github.com/tknerr/sample-toplevel-cookbook) and [sample-infrastructure-repo](https://github.com/tknerr/sample-infrastructure-repo)
* running various commands like `bundle install`, `vagrant plugin list`, `vagrant up`, etc..
* running different kinds of cookbook tests via `rubocop`, `foodcritic`, `chefspec` and `test-kitchen`

The acceptance test is not run by default, but you can run it manually from anywhere inside the VM:

```bash
git clone https://github.com/tknerr/vagrant-workflow-tests
cd vagrant-workflow-tests
rspec
```

If all goes well you should see an output [like this](https://cloud.githubusercontent.com/assets/365744/3607278/0579cae2-0d45-11e4-81f0-9236c592562a.png).

### Packaging

Whenever you feel like distributing a fat VM image rather than a Vagrantfile,
you can package / export it as a VirtualBox / VMware image. This might be useful
for distributing the initial version of the developer VM to your dev team,
or simply for preserving checkpoint releases as a binary images.

Let's start from a clean state:

```bash
vagrant destroy -f
vagrant up
```

This will provision the VM as usual. Once the provisioning succeeded, we will
do a few cleanup steps before packaging the VM.

First, unmount the /vagrant shared folder:

```bash
vagrant ssh -c "sudo umount /vagrant -f"
```

Then remove the vagrant user account:

```bash
vagrant ssh -c "sudo pkill -KILL -u vagrant"
vagrant ssh -c "sudo userdel -f -r vagrant"
```

Finally, shutdown the VM, remove the sharedfolder, and export the VM as an .ova file:

For VirtualBox:

```bash
vagrant halt
VBoxManage sharedfolder remove "Linus Kitchen" --name "vagrant"
VBoxManage modifyvm "Linus Kitchen" --name "Linus Kitchen v0.1.0"
VBoxManage export "Linus Kitchen v0.1.0" --output "linus-kitchen-v0.1.0_virtualbox.ova" --options manifest,nomacs
```

For VMware:

```bash
vagrant halt
VMX_FILE=`cat .vagrant/machines/default/vmware_fusion/id`
ovftool --name="Linus Kitchen v0.1.0" "$VMX_FILE" linus-kitchen-v0.1.0_vmware.ova
```

Don't forget to throw away the VM when you are done:

```bash
vagrant destroy -f
```

## Contributing

 1. Fork the repository on Github
 1. Create a named feature branch (like `feature/add-xyz`)
 1. Implement your changes, add tests
 1. Commit and push
 1. Submit a Pull Request via Github
