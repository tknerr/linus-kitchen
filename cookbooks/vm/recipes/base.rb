
include_recipe 'apt'

# commonly needed packages / tools
%w(vim libcurl4 gconf2 libxml2-dev libxslt1-dev zlib1g-dev liblzma-dev build-essential xvfb libxtst6 freerdp2-x11).each do |pkg|
  package pkg
end

# place a README on the Desktop
directory "#{vm_user_home}/Desktop" do
  owner vm_user
  group vm_user
  mode '0755'
end

cookbook_file "#{vm_user_home}/Desktop/README.md" do
  source "desktop_readme.md"
  owner vm_user
  group vm_user
  mode '0644'
end

execute "set bg" do
  user vm_user
  group vm_group
  environment vm_user_env
  command "dbus-launch --exit-with-session gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/Spring_by_Peter_Apas.jpg'"
end
