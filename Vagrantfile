
Vagrant::configure("2") do |config|

  # configure the basebox
  config.vm.box = "tknerr/ubuntu1604-desktop"
  config.vm.box_version = "2.0.27.1"

  # set the hostname
  config.vm.hostname = "linus-kitchen.local"
  # don't create a new keypair
  config.ssh.insert_key = false

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
  config.vm.provision "shell", privileged: true, path: 'scripts/setup-vm-user.sh', args: 'user user'

  # Install ChefDK and trigger the Chef run from within the VM
  config.vm.provision "shell", privileged: true, keep_color: true, run: 'always', inline: <<-EOF
    sudo -i -u user /vagrant/scripts/update-vm.sh #{ENV['UPDATE_VM_FLAGS']}
    EOF

  # Ensure we cache as much as possible
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.synced_folder_opts = {
      type: :nfs,
      mount_options: ['rw', 'vers=3', 'tcp', 'nolock'],
      export_options: ['async,insecure,no_subtree_check,no_acl,no_root_squash']
    }
    config.cache.enable :generic, {
      "chef_file_cache" => { cache_dir: "/root/.chef/local-mode-cache/cache" },
      "pip_cache" => { cache_dir: "/home/user/.cache/pip" },
      "berkshelf_cache" => { cache_dir: "/home/user/.berkshelf" },
      "vagrant_plugins_cache" => { cache_dir: "/home/user/.vagrant.d/gems/2.2.5/cache" },
      "vagrant_plugins_gemspecs" => { cache_dir: "/home/user/.vagrant.d/gems/2.2.5/specifications" },
      "atom_plugins_cache" => { cache_dir: "/home/user/.atom/.apm" }
    }
  end
end
