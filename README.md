Dev-Box
================

Vagrantfile for setting up an Ubuntu 13.04 development box with
 * git
 * vim
 * ruby
 * vagrant
 * lxc

Requirements
------------

You need VirtualBox, Vagrant + bindler installed. 

Usage
-----

Install required vagrant plugins:
```
$ vagrant plugin bundle
```

Bring up the dev-box VM:
```
$ vagrant up
```

Attributes
----------

You can configure the following attributes via `chef.json` in the Vagrantfile:
* `node['devbox']['user']` - the user you work with on the box (e.g. johndoe)
* `node['devbox']['group']` - the group of the above user to be created

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Torben Knerr
