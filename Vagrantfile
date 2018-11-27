
Vagrant::configure("2") do |config|

  # configure the basebox
  config.vm.box = "fasmat/ubuntu1804-desktop"
  config.vm.box_version = "19.0218.1"
  config.vm.box_check_update = false
  config.vm.guest = :ubuntu

  # set the hostname
  config.vm.hostname = "linus-kitchen.local"

  # don't create a new keypair
  config.ssh.insert_key = false

  # virtualbox specific customizations
  config.vm.provider :virtualbox do |vbox, override|
    vbox.customize ["modifyvm", :id, "--name", "Linus Kitchen"]
    vbox.customize ["modifyvm", :id, "--memory", 4096]
    vbox.customize ["modifyvm", :id, "--cpus", Etc.nprocessors]
    vbox.customize ["modifyvm", :id, "--vram", 256]
    vbox.customize ["modifyvm", :id, "--accelerate3d", "off"]
    vbox.customize ["modifyvm", :id, "--ioapic", "on"]
    vbox.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
    vbox.customize ["storagectl", :id, "--name", "SATA Controller", "--hostiocache", "on"]
    # Default: The VM is hosted on an SSD. 
    # Set to "off" if it is hosted on an HDD to enable performance optimizations for rotational drives (e.g. defragmentation):
    vbox.customize ["storageattach", :id, "--storagectl", "SATA Controller", "--port", 0, "--nonrotational", "on"]

    # yes we have a gui
    vbox.gui = true
  end

  # vmware specific customizations
  [:vmware_workstation, :vmware_fusion].each do |vmware_provider|
    config.vm.provider vmware_provider do |vmware, override|
      vmware.vmx["displayname"] = "Linus Kitchen"
      vmware.vmx["numvcpus"] = "#{Etc.nprocessors}"
      vmware.vmx["memsize"] = "4096"
      vmware.vmx["mouse.vusb.startConnected"] = "FALSE"
      vmware.vmx["vhv.enable"] = "TRUE"
    end
  end

  # override the basebox when testing (an approximation) with docker
  config.vm.provider :docker do |docker, override|
    override.vm.box = "tknerr/baseimage-ubuntu-18.04"
    override.vm.box_version = "1.0.0"
  end

  # create new login user and pre-provision the deploy key
  config.vm.provision "shell", privileged: true, path: "scripts/setup-vm-user.sh", args: "user user"

  # Install ChefDK and trigger the Chef run from within the VM
  config.vm.provision "shell", privileged: true, keep_color: true, run: "always", inline: <<-EOF
    sudo -i -u user /vagrant/scripts/update-vm.sh #{ENV["UPDATE_VM_FLAGS"]}
  EOF

  # Ensure we cache as much as possible
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.enable :generic, {
      "chef_file_cache" => {cache_dir: "/root/.chef/local-mode-cache/cache"},
      "berkshelf_cache" => {cache_dir: "/home/vagrant/.berkshelf"},
    }
  end
end
