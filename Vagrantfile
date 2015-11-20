
Vagrant::configure("2") do |config|

  # configure the basebox
  config.vm.box = "boxcutter/ubuntu1404-desktop"

  # override the basebox when testing (an approximation) with docker
  config.vm.provider :docker do |docker, override|
    override.vm.box = "tknerr/baseimage-ubuntu-14.04"
  end

  # set the hostname
  config.vm.hostname = "linus-kitchen.local"

  # virtualbox customizations
  config.vm.provider :virtualbox do |vbox, override|
    vbox.customize ["modifyvm", :id,
      "--name", "Linus Kitchen",
      "--memory", 4096,
      "--cpus", 4
    ]
    # yes we have a gui
    vbox.gui = true
  end

  # Install ChefDK and trigger the Chef run from within the VM
  config.vm.provision "shell", privileged: false, inline: "/vagrant/scripts/update-vm.sh"
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
