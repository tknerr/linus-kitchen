
vbox_version = '5.1.22'
vbox_deb_file = 'virtualbox-5.1_5.1.22-115126~Ubuntu~xenial_amd64.deb'
vbox_checksum = '4d964bb498284906c359de049c828199f97b6bfb1867005647b61bdffa6bdaf7'

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
