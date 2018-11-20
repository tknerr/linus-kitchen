
atom_version = '1.32.2'
atom_deb_file = "atom-v#{atom_version}-amd64.deb"

atom_plugins = {
  'atom-beautify' => '0.33.4',
  'minimap' => '4.29.9',
  'language-chef' => '3.5.1',
  'language-ansible' => '0.2.2',
}

# ensure we have the required gui packages for starting atom in docker / Travis CI
if docker?
  package ['libxss-dev', 'gconf2', 'libgtk2.0-0', 'libnotify4', 'gvfs-bin', 'xdg-utils']
end

# install atom editor
remote_file "#{Chef::Config[:file_cache_path]}/#{atom_deb_file}" do
  source "https://github.com/atom/atom/releases/download/v#{atom_version}/atom-amd64.deb"
  mode '0644'
end

dpkg_package 'atom' do
  source "#{Chef::Config[:file_cache_path]}/#{atom_deb_file}"
  version atom_version
end

# install atom plugins
atom_plugins.each do |name, version|
  install_atom_plugin(name, version)
end

# config tweaks
['config.cson', 'init.coffee'].each do |config|
  cookbook_file "#{vm_user_home}/.atom/#{config}" do
    source "atom_#{config}"
    owner vm_user
    group vm_group
    mode '0664'
  end
end
