
include_recipe "apt"

%w{ vim git libxml2-dev libxslt1-dev zlib1g-dev liblzma-dev }.each do |pkg|
  package pkg
end


template "/tmp/keyboard.seed" do
  source "keyboard.seed.erb"
  notifies :run, "bash[reconfigure-keyboard]"
end

bash "reconfigure-keyboard" do
  environment devbox_user_env
  user devbox_user
  group devbox_group
  code <<-EOH
    sudo debconf-set-selections /tmp/keyboard.seed
    sudo dpkg-reconfigure -f noninteractive keyboard-configuration
    udevadm trigger --subsystem-match=input --action=change
  EOH
  action :nothing
end