
# Dev-Box

Vagrantfile for setting up an Ubuntu Desktop 14.04 development box for infrastructure-as-code development with Vagrant, Chef & Co.

Yes, it is being set up with Vagrant and Chef, so it's a bit meta...

## Prerequisites

You need [VirtualBox](http://virtualbox.org/wiki/Downloads),
[ChefDK](https://github.com/chef/chef-dk) and [Vagrant](http://www.vagrantup.com/)
installed, along with the following Vagrant plugins:

 * [vagrant-omnibus](https://github.com/chef/vagrant-omnibus) - for automatically installing Chef in the VM
 * [vagrant-berkshelf](https://github.com/berkshelf/vagrant-berkshelf) - for automatically resolving Chef cookbook dependencies

If you are on a Windows system, you could also use the [Bill's Kitchen DevPack](https://github.com/tknerr/bills-kitchen),
which includes everything of the above, except for VirtualBox.

## Usage

Bring up the dev-box VM:
```
$ vagrant up
```

It will take a while until everything is downloaded and installed. Watch the
log output on the console for it to finish.

Initially the "vagrant" user will be logged in. That's the system account which
we use for setting up the VM. You should log out the "vagrant" user now, and
log in with the `node['devbox']['user']` specified in the Vagrantfile. If you
didn't change it, by default it will be:

 * username: `%USERNAME%`
 * password: `"bofh"`

Whenever you make changes to the chef recipes, you need to trigger the
provisioning again:
```
$ vagrant provision
```

Again, watch the console output to see the results.

## Keyboard Layout

Seems to be too hard to automate for me, so you have to do this manually:
```
sudo dpkg-reconfigure keyboard-configuration
```

## Attributes

You can configure the following attributes via `chef.json` in the Vagrantfile:

* `node['devbox']['user']` - the user you work with on the box (e.g. johndoe)
* `node['devbox']['group']` - the group of the above user to be created

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github
