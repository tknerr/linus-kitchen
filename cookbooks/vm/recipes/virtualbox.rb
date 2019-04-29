
vbox_version = '6.0.6'
vbox_deb_file = 'virtualbox-6.0_6.0.6-130049~Ubuntu~bionic_amd64.deb'
vbox_checksum = '333999b479e649b02b50138a74439d341ef1b3e55aa45902660fd38a52cbb00d'

# download virtualbox
remote_file "#{Chef::Config[:file_cache_path]}/#{vbox_deb_file}" do
  source "http://download.oracle.com/virtualbox/#{vbox_version}/#{vbox_deb_file}"
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
