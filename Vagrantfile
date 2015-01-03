
Vagrant::configure("2") do |config|

  # the Chef version to use
  config.omnibus.chef_version = "12.0.1"
  # enable berkshelf plugin
  config.berkshelf.enabled = true
  
  #
  # define the dev-box VM
  #
  config.vm.define :"dev-box" do | devbox_config |
    
    # configure the basebox
    devbox_config.vm.box = "box-cutter/ubuntu1404-desktop"
    
    # hostname 
    devbox_config.vm.hostname = "dev-box.local"

    # virtualbox customizations
    devbox_config.vm.provider :virtualbox do |vbox, override|
      vbox.customize ["modifyvm", :id,
        "--name", "dev-box",
        "--memory", 4096,
        "--cpus", 4
      ]
      # yes we have a gui
      vbox.gui = true
    end
    
    # provisioning
    devbox_config.vm.provision :chef_solo do |chef|
      chef.add_recipe "dev-box::default"
      chef.add_recipe "dev-box::tests"
      chef.json = {
        :devbox => {
          :user => ENV['USERNAME'],
          :kb => {
            :layout => 'German',
            :layoutcode => 'de'
          }
        }
      }
      chef.log_level = :info
      chef.formatter = :doc
    end
  end 
end
