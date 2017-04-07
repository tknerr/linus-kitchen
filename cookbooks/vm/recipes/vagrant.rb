
node.set['vagrant']['url'] = 'https://releases.hashicorp.com/vagrant/1.9.3/vagrant_1.9.3_x86_64.deb'
node.set['vagrant']['checksum'] = 'faff6befacc7eed3978b4b71f0dbb9c135c01d8a4d13236bda2f9ed53482d2c4'

include_recipe 'vagrant'

install_vagrant_plugin 'vagrant-cachier', '1.2.1'
install_vagrant_plugin 'vagrant-berkshelf', '5.1.1'
install_vagrant_plugin 'vagrant-omnibus', '1.5.0'
install_vagrant_plugin 'vagrant-toplevel-cookbooks', '0.2.4'
install_vagrant_plugin 'vagrant-lxc', '1.2.3'

bashd_entry 'set-vagrant-default-provider' do
  user devbox_user
  content 'export VAGRANT_DEFAULT_PROVIDER=docker'
end

#
# vagrant-lxc setup
#
%w(lxc lxc-templates cgroup-lite redir bridge-utils).each do |pkg|
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
