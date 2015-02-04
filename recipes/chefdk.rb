
node.set['chef_dk']['version'] = '0.4.0-1'
include_recipe "chef-dk"

bashd_entry "chefdk-shell-init" do
  user devbox_user
end

directory "#{devbox_userhome}/.bundle" do
  owner devbox_user
  group devbox_group
  mode "0755"
  action :create
end

template "#{devbox_userhome}/.bundle/config" do
  source "bundler_config.erb"
  owner devbox_user
  group devbox_group
  mode "0644"
end
