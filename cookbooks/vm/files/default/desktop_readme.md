
# README

A brief guide to walk you through the initial setup of this developer VM

## Initial Keyboard Setup

Configure the keyboard layout and adjust the timezone:

 * System Settings -> Region & Language
 * System Settings -> Details -> Date & Time

If you have a totally different keymap (e.g. on a MacBook) you can always reconfigure it:
```
sudo dpkg-reconfigure keyboard-configuration
```

If you are running the VM on a Mac with VMware, review the selected profile in keyboard & mouse system settings of the VM and chose the appropriate keyboard within the VM. Otherwise the keyboard mapping done by VMware may confuse you. To use the mac keyboard directly, select the "Mac-Profile" in the VM settings and choose the input source for Mac keyboards within the VM (e.g. "English (Macintosh)").

## Updating this Developer VM

You can run these commands from anywhere inside this developer VM:

 * `update-vm` - update the VM by applying the Chef recipes from the locally checked out repo at `~/vm-setup`
 * `update-vm --pull` - same as above, but update repo before by pulling the latest changes
 * `update-vm --verify-only` - don't update the VM, only run the Serverspec tests
 * `update-vm --provision-only` - don't run the Serverspec tests, only update the vm


## Getting Started!

Please refer to the sections below on how to start developing with the specific toolchain in this developer VM.

### Initial Git Configuration

Generate a new SSH keypair (and add the public key [to your Github account](https://github.com/settings/keys)):
```
ssh-keygen -t rsa -b 4096 -C "your.name@linus-kitchen"
```

Configure your git username / email:
```
git config --global user.name "Your Name"
git config --global user.email "your.name@isp.com"
```

### Follow the Tutorials

Now that you are all set up, you can follow the Chef / Vagrant tutorials in here:

 * https://entwicklertag.de/karlsruhe/2017/sites/entwicklertag.de.karlsruhe.2017/files/folien/Automatisierte%20Entwickler%20VMs.pdf 

