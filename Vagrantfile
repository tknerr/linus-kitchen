
Vagrant::configure("2") do |config|

  # enable cachier
  config.cache.auto_detect = true
  # the Chef version to use
  config.omnibus.chef_version = "11.10.4"
  # enable berkshelf plugin
  config.berkshelf.enabled = true
  
  #
  # define the dev-box VM
  #
  config.vm.define :"dev-box" do | devbox_config |
    
    # configure the basebox
    devbox_config.vm.box = "opscode_ubuntu-13.10_provisionerless"
    devbox_config.vm.box_url = "https://opscode-vm.s3.amazonaws.com/vagrant/opscode_ubuntu-13.10_provisionerless.box"
    
    # hostname 
    devbox_config.vm.hostname = "dev-box.local"

    # virtualbox customizations
    devbox_config.vm.provider :virtualbox do |vbox, override|
      vbox.customize ["modifyvm", :id,
        "--name", "dev-box",
        "--memory", 2048,
        "--cpus", 2
      ]
      # yes we have a gui
      vbox.gui = true
    end
    
    # provisioning
    devbox_config.vm.provision :chef_solo do |chef|
      chef.add_recipe "dev-box::default"
      chef.add_recipe "dev-box::tests"
      chef.json = {
      }
      chef.log_level = :debug
    end
  end 
end
