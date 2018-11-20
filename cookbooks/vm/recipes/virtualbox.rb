
vbox_version = '5.2.22'
vbox_deb_file = 'virtualbox-5.2_5.2.22-126460~Ubuntu~bionic_amd64.deb'
vbox_checksum = 'e45ff9ba50d9b6a6483952911537e478674c4a52852440104722fab0558b2622'

# download virtualbox
remote_file "#{Chef::Config[:file_cache_path]}/#{vbox_deb_file}" do
  source "http://download.virtualbox.org/virtualbox/#{vbox_version}/#{vbox_deb_file}"
  checksum vbox_checksum
  mode '0644'
end

bash 'install-virtualbox-with-dependencies' do
  code <<-EOF
    dpkg -i #{Chef::Config[:file_cache_path]}/#{vbox_deb_file} || true
    apt-get -y --fix-broken install
    EOF
  not_if "which vboxmanage && vboxmanage --version | grep -q '#{vbox_version}'"
end
