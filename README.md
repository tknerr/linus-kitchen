
# Linus' Kitchen

[![Circle CI](https://circleci.com/gh/tknerr/linus-kitchen/tree/master.svg?style=shield)](https://circleci.com/gh/tknerr/linus-kitchen/tree/master)

An Ubuntu Desktop 18.04 based development box for Infrastructure-as-Code development with Vagrant, Chef, Ansible & Co.

![Linus' Kitchen Screenshot](https://raw.github.com/tknerr/linus-kitchen/master/linus_kitchen.png)

Yes, it is being set up with Vagrant and Chef, so it's a bit meta...

It is based on the [Zuehlke/linux-developer-vm](https://github.com/Zuehlke/linux-developer-vm) template, and also the Linux based equivalent of [Bill's Kitchen](https://github.com/tknerr/bills-kitchen) (which explains the name).

## What's included?

### Main tools

These are the main tools included in Linus' Kitchen (see CHANGELOG for the specific versions):

  * [Ansible](https://www.ansible.com/)
  * [ChefDK](https://downloads.chef.io/chef-dk/)
  * [Docker](http://docker.io/)
  * [Git](https://git-scm.org/)
  * [Packer](http://packer.io/)
  * [Vagrant](http://vagrantup.com/)
  * [VirtualBox](https://www.virtualbox.org/)
  * [Visual Studio Code](https://code.visualstudio.com/)
  
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
  * Customized `~/.vagrant.d/Vagrantfile` and `~/.kitchen/config.yml` for caching as much as possible
  * Pre-installed Vagrant plugins:
    * [vagrant-cachier](https://github.com/fgrehm/vagrant-cachier) - caches all kinds of packages you install in the vagrant VMs
    * [vagrant-managed-servers](https://github.com/tknerr/vagrant-managed-servers) - Vagrant Provider for provisioning managed servers via SSH or WinRM
  * Pre-installed Visual Studio Code plugins:
    * [bbenoist.vagrant](https://marketplace.visualstudio.com/items?itemName=bbenoist.vagrant) - allows you to control Vagrant boxes from within VSCode
    * [dhoeric.ansible-vault](https://marketplace.visualstudio.com/items?itemName=dhoeric.ansible-vault) - encrypt/decrypt Ansible vault credentials
    * [donjayamanne.githistory](https://marketplace.visualstudio.com/items?itemName=donjayamanne.githistory) -  view and search the Git history, compare branches, do cherry-picking and more
    * [eamodio.gitlens](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens) - Various features, most notably an inline Git blame with tooltips
    * [felipecaputo.git-project-manager](https://marketplace.visualstudio.com/items?itemName=felipecaputo.git-project-manager) - configure a list of directories containing Git repositories and navigate through those indexed repositories easily
    * [mde.select-highlight-minimap](https://marketplace.visualstudio.com/items?itemName=mde.select-highlight-minimap) - directly spot highlighted selections in the minimap
    * [ms-python.python](https://marketplace.visualstudio.com/items?itemName=ms-python.python) - provides Python integration
    * [ms-vscode.sublime-keybindings](https://marketplace.visualstudio.com/items?itemName=ms-vscode.sublime-keybindings) - Import your Sublime Text settings and keybindings
    * [Pendrica.chef](https://marketplace.visualstudio.com/items?itemName=Pendrica.chef) - supports the Chef DSL, plenty of Chef snippets
    * [PeterJausovec.vscode-docker](https://marketplace.visualstudio.com/items?itemName=PeterJausovec.vscode-docker) - Easily add configuration files for Docker, Docker Compose to your project. Syntax highlighting and linting for `Dockerfile` files.
    * [rebornix.ruby](https://marketplace.visualstudio.com/items?itemName=rebornix.ruby) - Ruby integration
    * [vscoss.vscode-ansible](https://marketplace.visualstudio.com/items?itemName=vscoss.vscode-ansible) - runs Ansible Playbooks, provides code snippets, syntax highlighting and YAML validation
    * [yzhang.markdown-all-in-one](https://marketplace.visualstudio.com/items?itemName=yzhang.markdown-all-in-one) - Makes editing Markdown files easier. Supports e.g. creation of a TOC, some auto-completion, and export to HTML
    * [zikalino.azure-rest-for-ansible](https://marketplace.visualstudio.com/items?itemName=zikalino.azure-rest-for-ansible) - call the Azure REST API from within VSCode, e.g. control VMs and run provided examples. Creates Ansible playbooks.
  * Placed a `README.md` file on the Desktop to guide first time users after they logged in to the VM
  * Symlinked [`update-vm.sh`](scripts/update-vm.sh) to `/usr/local/bin/update-vm` so it's in the `$PATH` and can be used for updating the VM from the inside (see below)

## Usage

### Obtaining and Starting the VM Image

The latest version of the Linus Kitchen can be downloaded as a VM image from here:

  * https://github.com/tknerr/linus-kitchen/releases

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
```
sudo dpkg-reconfigure keyboard-configuration
```

If want to reconfigure the locale:
```
sudo dpkg-reconfigure locales
```

## Development

### Prerequisites

You need [VMware Workstation Pro](https://www.vmware.com/products/workstation.html) / [VMware Fusion Pro](https://www.vmware.com/products/workstation.html) and [Vagrant](http://www.vagrantup.com/) with the [vagrant-vmware-plugin](https://www.vagrantup.com/vmware/) installed.

If you don't mind about running 64-bit VirtualBox VMs inside Linus Kitchen, you only even need [VirtualBox](http://virtualbox.org/wiki/Downloads) and [Vagrant](http://www.vagrantup.com/) installed (note that VirtualBox only supports nested 32-bit guests).

All other requirements, including ChefDK will be installed *inside the Vagrant VM* during provisioning, i.e. you don't need them installed on your host machine.

### Basic Development Workflow

Bring up the developer VM:
```
$ vagrant up
```

This will take a while, as it will do quite a few things inside the VM:

 1. Setup a new user account ('user') under which the VM will be provisioned
 2. Download and install [ChefDK](https://downloads.chef.io/chef-dk/)
 3. Copy the current directory into the VM (will be placed in `~/vm-setup`)
 4. Install cookbook dependencies via [Berkshelf](http://berkshelf.com/) to `~/vm-setup/cookbooks/vm/cookbooks`
 5. Trigger a [Chef-Zero](https://www.chef.io/blog/2013/10/31/chef-client-z-from-zero-to-chef-in-8-5-seconds/) run to apply the `~/vm-setup/cookbooks/vm/recipes` to the VM (see "What's included?")
 6. Verify the installation using a battery of [Serverspec](http://serverspec.org/) tests

Watch the vagrant output on the console for seeing progress. At the end you
should see all tests passing:

```
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
```
$ git clone https://github.com/tknerr/vagrant-workflow-tests
$ cd vagrant-workflow-tests
$ rspec
```

If all goes well you should see an output [like this](https://cloud.githubusercontent.com/assets/365744/3607278/0579cae2-0d45-11e4-81f0-9236c592562a.png).

### Packaging

Whenever you feel like distributing a fat VM image rather than a Vagrantfile,
you can package / export it as a VirtualBox / VMware image. This might be useful
for distributing the initial version of the developer VM to your dev team,
or simply for preserving checkpoint releases as a binary images.

Let's start from a clean state:
```
$ vagrant destroy -f
$ vagrant up
```

This will provision the VM as usual. Once the provisioning succeeded, we will
do a few cleanup steps before packaging the VM.

First, unmount the /vagrant shared folder:
```
$ vagrant ssh -c "sudo umount /vagrant -f"
```

Then remove the vagrant user account:
```
$ vagrant ssh -c "sudo pkill -KILL -u vagrant"
$ vagrant ssh -c "sudo userdel -f -r vagrant"
```

Finally, shutdown the VM, remove the sharedfolder, and export the VM as an .ova file:

For VirtualBox:
```
$ vagrant halt
$ VBoxManage sharedfolder remove "Linus Kitchen" --name "vagrant"
$ VBoxManage modifyvm "Linus Kitchen" --name "Linus Kitchen v0.1.0"
$ VBoxManage export "Linus Kitchen v0.1.0" --output "linus-kitchen-v0.1.0_virtualbox.ova" --options manifest,nomacs
```

For VMware:
```
$ vagrant halt
$ VMX_FILE=`cat .vagrant/machines/default/vmware_fusion/id`
$ ovftool --name="Linus Kitchen v0.1.0" "$VMX_FILE" linus-kitchen-v0.1.0_vmware.ova
```

Don't forget to throw away the VM when you are done:
```
$ vagrant destroy -f
```

## Contributing

 1. Fork the repository on Github
 1. Create a named feature branch (like `feature/add-xyz`)
 1. Implement your changes, add tests
 1. Commit and push
 1. Submit a Pull Request via Github
