
Vagrant::configure("2") do |config|

  # configure the basebox
  config.vm.box = "tknerr/ubuntu1604-desktop"
  config.vm.box_version = "2.0.27.1"

  # set the hostname
  config.vm.hostname = "linus-kitchen.local"

  # virtualbox specific customizations
  config.vm.provider :virtualbox do |vbox, override|
    vbox.customize ["modifyvm", :id,
      "--name", "Linus Kitchen",
      "--memory", 4096,
      "--cpus", Etc.nprocessors
    ]
    # yes we have a gui
    vbox.gui = true
  end

  # vmware specific customizations
  [ :vmware_workstation, :vmware_fusion ].each do |vmware_provider|
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
    override.vm.box = "tknerr/baseimage-ubuntu-16.04"
    override.vm.box_version = "1.0.0"
  end

  # create new login user and pre-provision the deploy key
  config.vm.provision "shell", privileged: true, path: 'scripts/setup-vm-user.sh', args: 'linus linus'

  # Install ChefDK and trigger the Chef run from within the VM
  config.vm.provision "shell", privileged: true, keep_color: true, run: 'always', inline: <<-EOF
    sudo -i -u linus /vagrant/scripts/update-vm.sh #{ENV['UPDATE_VM_FLAGS']}
    EOF
  # Logout any existing GUI session to force the use to re-login, which is required
  # for group or keyboard layout changes to take effect
  config.vm.provision "shell", privileged: true, inline: "pkill -KILL -u vagrant; true"

  # Ensure we cache as much as possible
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.enable :generic, {
      "chef_file_cache" => { cache_dir: "/home/vagrant/.chef/local-mode-cache/cache" }
    }
  end
end
