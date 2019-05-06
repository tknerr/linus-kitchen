
vagrant_version = '2.2.4'
vagrant_deb_file = "vagrant_#{vagrant_version}_x86_64.deb"
vagrant_checksum = '1ffb66020b580492ebf9189af8a48c48cdb31825be0717d600518a881584fe4a'

vagrant_plugins = {
  'vagrant-cachier' => '1.2.1',
  'vagrant-managed-servers' => '0.8.0'
}

# download and install vagrant
remote_file "#{Chef::Config[:file_cache_path]}/#{vagrant_deb_file}" do
  source "https://releases.hashicorp.com/vagrant/#{vagrant_version}/#{vagrant_deb_file}"
  checksum vagrant_checksum
end

dpkg_package 'vagrant' do
  source "#{Chef::Config[:file_cache_path]}/#{vagrant_deb_file}"
  version vagrant_version
  not_if "which vagrant && vagrant --version | grep -q '#{vagrant_version}'"
end

# install vagrant plugins
vagrant_plugins.each do |name, version|
  install_vagrant_plugin(name, version)
end

# set default provider
bashrc_manager 'set-vagrant-default-provider' do
  user vm_user
  content "export VAGRANT_DEFAULT_PROVIDER=#{vmware? ? 'virtualbox' : 'docker'}"
end

#
# tricks to make vagrant-cachier kick in during test-kitchen runs
#
template "#{vm_user_home}/.vagrant.d/Vagrantfile" do
  source 'Vagrantfile.erb'
  owner vm_user
  group vm_group
  mode '0644'
end

directory "#{vm_user_home}/.kitchen" do
  owner vm_user
  group vm_group
  mode '0755'
end

template "#{vm_user_home}/.kitchen/config.yml" do
  source 'kitchen_config.erb'
  owner vm_user
  group vm_group
  mode '0644'
end
