
include_recipe 'apt'

# commonly needed packages / tools
%w(vim gconf2 libxml2-dev libxslt1-dev zlib1g-dev liblzma-dev build-essential xvfb indicator-multiload).each do |pkg|
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
