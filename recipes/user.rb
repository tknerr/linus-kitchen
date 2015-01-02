
group node['devbox']['group'] do
  action :create
end

user node['devbox']['user'] do
  action :create
  gid node['devbox']['group']
  home "/home/#{node['devbox']['user']}"
  shell "/bin/bash"
  password `openssl passwd -1 "bofh"`.strip
  supports :manage_home => true 
end

# XXX: consider using sudo cookbook
group "sudo" do
  action :modify
  members node['devbox']['user']
  append true
end

# disable auto-login of the vagrant user in gui mode
template "/etc/lightdm/lightdm.conf" do
  source "lightdm.conf.erb"
  owner "root"
  group "root"
  mode "0644"
end

