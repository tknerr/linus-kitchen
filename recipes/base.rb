
include_recipe "apt"

%w{ vim git libxml2-dev libxslt1-dev zlib1g-dev liblzma-dev }.each do |pkg|
  package pkg
end


template "/tmp/keyboard.seed" do
  source "keyboard.seed.erb"
  notifies :run, "bash[reconfigure-keyboard]"
end

bash "reconfigure-keyboard" do
  code <<-EOH
    sudo -u #{devbox_user} sudo debconf-set-selections /tmp/keyboard.seed
    sudo -u #{devbox_user} sudo dpkg-reconfigure -f noninteractive keyboard-configuration
    sudo -u #{devbox_user} udevadm trigger --subsystem-match=input --action=change
  EOH
  action :nothing
end
