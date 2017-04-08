
# Linus' Kitchen

[![Circle CI](https://circleci.com/gh/tknerr/linus-kitchen/tree/master.svg?style=shield)](https://circleci.com/gh/tknerr/linus-kitchen/tree/master)

An Ubuntu Desktop 16.04 based development box for Infrastructure-as-Code development with Vagrant, Chef & Co.

![Linus' Kitchen Screenshot](https://raw.github.com/tknerr/linus-kitchen/master/linus_kitchen.png)

Yes, it is being set up with Vagrant and Chef, so it's a bit meta... It is also the Linux based equivalent of the [Bill's Kitchen](https://github.com/tknerr/bills-kitchen) DevPack.

## Prerequisites

You only need [VirtualBox](http://virtualbox.org/wiki/Downloads) and [Vagrant](http://www.vagrantup.com/)
installed.

All other requirements, along with ChefDK and Git will be installed *inside the Vagrant VM* during provisioning, i.e. you don't need them installed on your host machine.

## Basic Usage

Bring up the linus-kitchen VM:
```
$ vagrant up
```

This will take a while, as it will do quite a few things inside the VM:

 1. Download and install [Git](https://git-scm.org/) and [ChefDK](https://downloads.chef.io/chef-dk/)
 1. Copy the current directory into the VM (will be placed in `~/vm-setup`)
 1. Install cookbook dependencies via [Berkshelf](http://berkshelf.com/) to `~/vm-setup/cookbooks/vm/cookbooks`
 1. Trigger a [Chef-Zero](https://www.chef.io/blog/2013/10/31/chef-client-z-from-zero-to-chef-in-8-5-seconds/) run to apply the `~/vm-setup/cookbooks/vm/recipes` to the VM (see "What's included?")
 1. Verify the installation using a battery of [Serverspec](http://serverspec.org/) tests

Watch the vagrant output on the console for seeing progress. At the end you
should see all tests passing:

```
...
==> default:
==> default: update-vm.sh
==> default:   installs git
==> default:   installs chefdk 1.3.32
==> default:
==> default: Finished in 24.44 seconds (files took 0.81272 seconds to load)
==> default: 33 examples, 0 failures
...
```

You can now log in to the Desktop (the VM is started in GUI mode):

 * user: "vagrant"
 * password: "vagrant"

Once logged in, you can open a terminal and you will have all of the tools available (see next section).

## What's included?

These are the main tools included in Linus' Kitchen:

 * [Git](https://git-scm.org/)
 * [ChefDK](https://downloads.chef.io/chef-dk/)
 * [Vagrant](http://vagrantup.com/)
 * [Docker](http://docker.io/)
 * [Atom Editor](http://terraform.io/)

Other tweaks worth mentioning:

 * Scripts in `~/.bash.d/*.sh` are sourced from `~/.bashrc`, pre-configured with the following:
  * set up `be` as an alias for `bundle exec`
  * run `chef shell-init bash` for initializing the ChefDK
  * configure "docker" as the `$VAGRANT_DEFAULT_PROVIDER`
 * Bundler is configured for parallel downloading and retrying (see `~/.bundle/config`)
 * Customized Atom config, e.g. with SublimeText-like tab behaviour (see `~/.atom/config.cson`)
 * Customized `~/.vagrant.d/Vagrantfile` and `~/.kitchen/config.yml` for caching as much as possible
 * Pre-installed Vagrant plugins:
   * [vagrant-omnibus](https://github.com/schisamo/vagrant-omnibus) - installs omnibus chef in a vagrant VM
   * [vagrant-cachier](https://github.com/fgrehm/vagrant-cachier) - caches all kinds of packages you install in the vagrant VMs
   * [vagrant-berkshelf](https://github.com/berkshelf/vagrant-berkshelf) - berkshelf integration for vagrant
   * [vagrant-toplevel-cookbooks](https://github.com/tknerr/vagrant-toplevel-cookbooks) - support for one top-level cookbook per vagrant VM
   * [vagrant-lxc](https://github.com/fgrehm/vagrant-lxc) - LXC provider for Vagrant
 * Pre-installed Atom plugins:
   * [atom-beautify](https://atom.io/packages/atom-beautify) - code formatter / beautifier for various languages
   * [minimap](https://atom.io/packages/minimap) - a SublimeText like minimap
   * [line-ending-converter](https://atom.io/packages/line-ending-converter) - show and convert between line ending styles
   * [language-chef](https://atom.io/packages/language-chef) - code snippets for Chef recipes
 * Symlinked [`update-vm.sh`](scripts/update-vm.sh) to `/usr/local/bin/update-vm` so it's in the `$PATH` and can be used for updating the VM from the inside (see below)

## Updating Linus' Kitchen

Even though you can trigger an update from outside the VM via `vagrant provision`,
you usually want to do that from *inside the VM* as this is your current working environment.
The update is done via Chef so it should be fully idempotent.

You can run these commands from anywhere inside the VM:

 * `update-vm` - to apply the Chef recipes of the locally checked out linus-kitchen repo in `~/vm-setup`
 * `update-vm --pull` - same as above but update the repo before
 * `update-vm --verify-only` - don't update the VM, only run the Serverspec tests

## Acceptance Test

In addition to the Serverspec tests (which verify that the installed tools are properly
configured and working as expected) you can also execute a minimal acceptance test which covers the [common usage scenarios](https://github.com/tknerr/vagrant-workflow-tests/blob/master/spec/acceptance/usage_scenarios_spec.rb) when developing with Vagrant and Chef, including:

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

## Keyboard Layout

Seems to be too hard to automate for me, so you have to do this manually for now:
```
sudo dpkg-reconfigure keyboard-configuration
```

## Packaging

Whenever you feel like distributing a fat VM image rather than a Vagrantfile,
you can package / export it as a VirtualBox image. This might be useful
for distributing the initial version of the developer VM to your dev team,
or simply for preserving checkpoint releases as a binary images.

First, start from a clean state, and make sure vagrant-cachier is disabled:
```
$ vagrant destroy -f
$ export VAGRANT_NO_PLUGINS=1
$ vagrant up
```

Next, unmount the /vagrant shared folder (will be restored on next `vagrant up`):
```
$ vagrant ssh -c "sudo umount /vagrant"
```

Also, you may want to clean out the VM for a minimal export image:
```
$ vagrant ssh -c "wget -qO- https://raw.githubusercontent.com/boxcutter/ubuntu/master/script/cleanup.sh | sudo bash"
```

Finally, shutdown the VM, remove the sharedfolder, and export the VM as an .ova file:
```
$ vagrant halt
$ VBoxManage sharedfolder remove "Linus Kitchen" --name "vagrant"
$ VBoxManage modifyvm "Linus Kitchen" --name "Linus Kitchen v0.1"
$ VBoxManage export "Linus Kitchen v0.1" --output "linus-kitchen-v0.1.ova" --options manifest,nomacs
```

Don't forget to throw away the VM enable vagrant-cachier again:
```
$ vagrant destroy -f
$ unset VAGRANT_NO_PLUGINS
```

## Contributing

 1. Fork the repository on Github
 1. Create a named feature branch (like `add-xyz`)
 1. Implement your changes, add tests
 1. Commit and push
 1. Submit a Pull Request using Github
