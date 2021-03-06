# CHANGELOG

## unreleased

 * ...

## 0.6 (May 9, 2019)

Bugfixes:

 * ensure correct version of docker cli and daemon are installed (see [PR #88](https://github.com/tknerr/linus-kitchen/pull/88))
 * fix incorrect line endings in Git PS1 when provisioned from Windows host (see [PR #86](https://github.com/tknerr/linus-kitchen/pull/86))
 * fix broken status indication in Git PS1 prompt (see [PR #83](https://github.com/tknerr/linus-kitchen/pull/83))
 * fix broken "Sofware Updater" by disabling vagrant-cachier when packaging the VM (see [PR #81](https://github.com/tknerr/linus-kitchen/pull/81))
 * fix broken `apt-get update` due to duplicate definition of docker apt sources (see [PR #80](https://github.com/tknerr/linus-kitchen/pull/80))

Improvements:

 * remove docker-in-docker related workarounds no longer needed with CircleCI 2.0 (see [PR #87](https://github.com/tknerr/linus-kitchen/pull/87))
 * disable vagrant-cachier caching by default and allow to opt-in instead (see [PR #85](https://github.com/tknerr/linus-kitchen/pull/85))
 * install xfreerdp so that we can use `vagrant rdp` with Windows VMs (see [PR #84](https://github.com/tknerr/linus-kitchen/pull/84))
 * improve README regarding regional settings and input languages (see [PR #82](https://github.com/tknerr/linus-kitchen/pull/82))
 * make chef run fully idempotent again (see [PR #79](https://github.com/tknerr/linus-kitchen/pull/79))

## 0.5 (Apr 29, 2019)

Updated tools:

 * updated to latest "fasmat/ubuntu1804-desktop" basebox version 19.0218.1 (see [PR #73](https://github.com/tknerr/linus-kitchen/pull/73))
 * updated to latest tool versions (see [PR #76](https://github.com/tknerr/linus-kitchen/pull/76)):
   * Vagrant 2.2.4
   * VirtualBox 6.0.6
   * ChefDK 3.9.0
   * Docker 18.09.5
   * Ansible 2.7.10
   * Ansible related tools:
      * ansible-lint 4.1.0
      * testinfra 1.19.0 (we can't update to 2.1.0 as molecule 2.20.1 has a hard requirement on 1.19.0)
      * molecule 2.20.1
   * vscode 1.33.1 (and updated plugins)

Improvements:

 * updated to CircleCI 2.0 (see [PR #75](https://github.com/tknerr/linus-kitchen/pull/75))
 * replaced atom with vscode (see [PR #71](https://github.com/tknerr/linus-kitchen/pull/71), [PR #74](https://github.com/tknerr/linus-kitchen/pull/74), thanks @jotbe !)
 * activated host I/O cache for Virtualbox provider and assume an SSD storage (see [PR #70](https://github.com/tknerr/linus-kitchen/pull/70), thanks @jotbe !)

Removed tools:

 * removed outdated / deprecated vagrant plugins (see [PR #77](https://github.com/tknerr/linus-kitchen/pull/77)):
   * vagrant-omnibus
   * vagrant-berkshelf
   * vagrant-toplevel-cookbooks

## 0.4 (Nov 20, 2018)

Updated tools:

 * updated basebox to Ubuntu 18.04 (see [PR #68](https://github.com/tknerr/linus-kitchen/pull/68), thanks @fasmat !)
    * optimized performance of VM in Virtualbox
    * update to ChefDK v3.4.23 and cookbooks
    * update to Vagrant v2.2.0 and plugins
    * update to Atom v1.32.2 and plugins
    * update to Docker v18.06.1
    * update to Packer v1.3.2
    * update to VirtualBox v5.2.22
 * updated the ansible toolchain (see [PR #66](https://github.com/tknerr/linus-kitchen/pull/66))
    * added python-vagrant wrapper so we can use molecule's vagrant driver
    * update to molecule v2.19.0
    * update to testinfra v1.16.0

## 0.3 (May 30, 2017)

Updated tools:

 * update to Vagrant v1.9.5 (see [PR #58](https://github.com/tknerr/linus-kitchen/pull/58))
 * update to VirtualBox v5.1.22 (see [PR #59](https://github.com/tknerr/linus-kitchen/pull/59))
 * update to Docker v17.05.0-ce (see [PR #61](https://github.com/tknerr/linus-kitchen/pull/61))
 * update to ChefDK v1.4.3 (see [PR #62](https://github.com/tknerr/linus-kitchen/pull/62))
 * update to Atom Editor v1.17.1 and plugins (see [PR #60](https://github.com/tknerr/linus-kitchen/pull/60)):
    * atom-beautify to v0.29.24
    * atom-minimap to v4.28.2
    * language-ansible to v0.2.1 (new)

Newly installed tools:

 * installed a toolchain for developing with [Ansible](https://www.ansible.com/) (see [PR #63](https://github.com/tknerr/linus-kitchen/pull/63)), including:
    * ansible v2.3.0.0
    * molecule v2.0.0.rc6
    * testinfra v1.6.3
    * ansible-lint v3.4.12

## 0.2 (May 12, 2017)

Updated tools:

 * update to Ubuntu 16.04 basebox (see [PR #29](https://github.com/tknerr/linus-kitchen/pull/29))
 * update to ChefDK 1.3.40 (see [PR #32](https://github.com/tknerr/linus-kitchen/pull/32), [PR #55](https://github.com/tknerr/linus-kitchen/pull/55))
 * update Vagrant to v1.9.3 and plugins (see [PR #33](https://github.com/tknerr/linus-kitchen/pull/33), [PR #41](https://github.com/tknerr/linus-kitchen/pull/41)):
    * vagrant-omnibus to v1.5.0
    * vagrant-berkshelf to v5.1.1
    * vagrant-lxc to v1.2.3
    * vagrant-managed-servers v0.8.0 (new plugin, see [PR #43](https://github.com/tknerr/linus-kitchen/pull/43))
 * update to Docker 17.04.0-ce (see [PR #34](https://github.com/tknerr/linus-kitchen/pull/34), [PR #46](https://github.com/tknerr/linus-kitchen/pull/46))
 * update to Atom Editor v1.15.0 and plugins (see [PR #35](https://github.com/tknerr/linus-kitchen/pull/35)):
    * atom-beautify to v0.29.18
    * atom-minimap to v4.27.1
    * removed: language-batchfile (not needed)
    * removed: line-ending-converter (part of atom core)

Newly installed tools:

 * installs VirtualBox 5.1.18 and make it the default vagrant provider (see [PR #28](https://github.com/tknerr/linus-kitchen/pull/28))
 * installs Packer 1.0.0 (see [PR #36](https://github.com/tknerr/linus-kitchen/pull/36))
 * installs the indicator-multiload applet for monitoring system resources (see [PR #37](https://github.com/tknerr/linus-kitchen/pull/37))

Improvements:

 * various minor improvements when provisioning via Vagrant (see [PR #39](https://github.com/tknerr/linus-kitchen/pull/39)):
    * use all available CPU cores when starting the VM via vagrant
    * force colored output when provisioning the VM without a tty
    * adjust chef-zero log level when provisioning the VM without a tty
 * noticeably improve chef-zero startup time by disabling the vmware ohai plugin (see [PR #40](https://github.com/tknerr/linus-kitchen/pull/40))
 * add `--provision-only` flag to the `update-vm.sh` script (see [PR #42](https://github.com/tknerr/linus-kitchen/pull/42), [PR #47](https://github.com/tknerr/linus-kitchen/pull/47))
 * configure PS1 to provide a usable shell prompt for Git (see [PR #45](https://github.com/tknerr/linus-kitchen/pull/45))
 * tweak Atom to scale the tree view's font size along with the editor (see [PR #49](https://github.com/tknerr/linus-kitchen/pull/49))
 * restructure the README to better differentiate between Usage and Development (see [PR #50](https://github.com/tknerr/linus-kitchen/pull/50))
 * added a `LICENSE` file to provide the sources under MIT license (see [PR #51](https://github.com/tknerr/linus-kitchen/pull/51))
 * cleanup: renove outdated workarounds, TODOs and rubocop linting (see [PR #54](https://github.com/tknerr/linus-kitchen/pull/54))
 * place a README on the Desktop for better guiding the user (see [PR #56](https://github.com/tknerr/linus-kitchen/pull/56))

Breaking changes:

 * the VM is now provisioned under a dedicated user account 'user', and thus the 'vagrant' user account can now be removed before packaging the box (see [PR #44](https://github.com/tknerr/linus-kitchen/pull/44))

## 0.1 (May 11, 2016)

The initial release of the linus-kitchen developer VM.

It includes:

 * ChefDK 0.13.21
 * Vagrant 1.8.1
 * Docker 1.11
 * Git 1.9
 * Atom Editor 1.7.3

See the [README](https://github.com/tknerr/linus-kitchen/blob/master/README.md) for more details.
