
# download and install vagrant
vagrant_version = node.fetch("vagrant_version", "")
vagrant_deb_file = "vagrant_#{vagrant_version}_x86_64.deb"
vagrant_checksum = node.fetch("vagrant_checksum", "")

remote_file "#{Chef::Config[:file_cache_path]}/#{vagrant_deb_file}" do
  source "https://releases.hashicorp.com/vagrant/#{vagrant_version}/#{vagrant_deb_file}"
  checksum vagrant_checksum
  mode "0644"
  notifies :install, "dpkg_package[vagrant]", :immediately
end

dpkg_package "vagrant" do
  source "#{Chef::Config[:file_cache_path]}/#{vagrant_deb_file}"
  version vagrant_version
end

# install vagrant plugins
vagrant_plugins = node.fetch("vagrant_plugins", [])
vagrant_plugins.each do |plugin|
  install_vagrant_plugin(plugin["name"], plugin["version"])
end

# set default provider
bashrc_manager "set-vagrant-default-provider" do
  user vm_user
  content "export VAGRANT_DEFAULT_PROVIDER=#{vmware? ? "virtualbox" : "docker"}"
end

#
# vagrant-lxc setup
#
%w(lxc lxc-templates cgroup-lite redir bridge-utils).each do |pkg|
  package pkg
end

bash "add vagrant-lxc sudoers permissions" do
  environment vm_user_env
  code "vagrant lxc sudoers"
  not_if { ::File.exist? "/etc/sudoers.d/vagrant-lxc" }
end

#
# tricks to make vagrant-cachier kick in during test-kitchen runs
#
template "#{vm_user_home}/.vagrant.d/Vagrantfile" do
  source "Vagrantfile.erb"
  owner vm_user
  group vm_group
  mode "0644"
end

directory "#{vm_user_home}/.kitchen" do
  owner vm_user
  group vm_group
  mode "0755"
end

template "#{vm_user_home}/.kitchen/config.yml" do
  source "kitchen_config.erb"
  owner vm_user
  group vm_group
  mode "0644"
end
