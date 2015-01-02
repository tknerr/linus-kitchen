
group devbox_group do
  action :create
end

user devbox_user do
  action :create
  gid devbox_group
  home devbox_userhome
  shell "/bin/bash"
  password `openssl passwd -1 "bofh"`.strip
  supports :manage_home => true 
end

# XXX: consider using sudo cookbook
group "sudo" do
  action :modify
  members devbox_user
  append true
end

# disable auto-login of the vagrant user in gui mode
template "/etc/lightdm/lightdm.conf" do
  source "lightdm.conf.erb"
  owner "root"
  group "root"
  mode "0644"
end

