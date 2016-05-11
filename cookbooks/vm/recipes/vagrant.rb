
node.set['vagrant']['url'] = 'https://releases.hashicorp.com/vagrant/1.8.1/vagrant_1.8.1_x86_64.deb'
node.set['vagrant']['checksum'] = 'ed0e1ae0f35aecd47e0b3dfb486a230984a08ceda3b371486add4d42714a693d'

include_recipe 'vagrant'

install_vagrant_plugin 'vagrant-cachier', '1.2.1'
install_vagrant_plugin 'vagrant-berkshelf', '4.1.0'
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
