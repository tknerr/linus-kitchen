
node.set[:vagrant][:url] = 'https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.4_x86_64.deb'
node.set[:vagrant][:checksum] = 'dcd2c2b5d7ae2183d82b8b363979901474ba8d2006410576ada89d7fa7668336'

include_recipe 'vagrant'

install_vagrant_plugin 'vagrant-cachier', '1.2.1'
install_vagrant_plugin 'vagrant-berkshelf', '4.0.4'
install_vagrant_plugin 'vagrant-omnibus', '1.4.1'
install_vagrant_plugin 'vagrant-toplevel-cookbooks', '0.2.4'
install_vagrant_plugin 'vagrant-lxc', '1.1.0'

bashd_entry 'set-vagrant-default-provider' do
  user devbox_user
  content 'export VAGRANT_DEFAULT_PROVIDER=docker'
end

#
# vagrant-lxc setup
#
%w( lxc lxc-templates cgroup-lite redir bridge-utils ).each do |pkg|
  package pkg
end

bash 'add vagrant-lxc sudoers permissions' do
  environment devbox_user_env
  code 'vagrant lxc sudoers'
  not_if { ::File.exist? '/etc/sudoers.d/vagrant-lxc' }
end

#
# tricks to make vagrant-cachier kick in during test-kitchen runs
#
template "#{devbox_userhome}/.vagrant.d/Vagrantfile" do
  source 'Vagrantfile.erb'
  owner devbox_user
  group devbox_group
  mode '0644'
end
directory "#{devbox_userhome}/.kitchen" do
  owner devbox_user
  group devbox_group
  mode '0755'
end
template "#{devbox_userhome}/.kitchen/config.yml" do
  source 'kitchen_config.erb'
  owner devbox_user
  group devbox_group
  mode '0644'
end
