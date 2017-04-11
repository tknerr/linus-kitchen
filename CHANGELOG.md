# CHANGELOG

## 0.2 (unreleased)

Updated tools:

 * update to Ubuntu 16.04 basebox (see [PR #29](https://github.com/tknerr/linus-kitchen/pull/29))
 * update to ChefDK 1.3.32 (see [PR #32](https://github.com/tknerr/linus-kitchen/pull/32))
 * update Vagrant to v1.9.3 and plugins (see [PR #33](https://github.com/tknerr/linus-kitchen/pull/33)):
    * vagrant-omnibus to v1.5.0
    * vagrant-berkshelf to v5.1.1
    * vagrant-lxc to v1.2.3
 * update to Docker 1.13.1 (see [PR #34](https://github.com/tknerr/linus-kitchen/pull/34))
 * update to Atom Editor v1.15.0 and plugins (see [PR #35](https://github.com/tknerr/linus-kitchen/pull/35)):
    * atom-beautify to v0.29.18
    * atom-minimap to v4.27.1
    * removed: language-batchfile (not needed)
    * removed: line-ending-converter (part of atom core)


Newly installed tools:

 * installs VirtualBox 5.1.18 and make it the default vagrant provider (see [PR #28](https://github.com/tknerr/linus-kitchen/pull/28))
 * installs Packer 1.0.0 (see [PR #36](https://github.com/tknerr/linus-kitchen/pull/36))


## 0.1 (May 11, 2016)

The initial release of the linus-kitchen developer VM.

It includes:

 * ChefDK 0.13.21
 * Vagrant 1.8.1
 * Docker 1.11
 * Git 1.9
 * Atom Editor 1.7.3

See the [README](https://github.com/tknerr/linus-kitchen/blob/master/README.md) for more details.
