
atom_version = '1.17.1'
atom_deb_file = "atom-v#{atom_version}-amd64.deb"

atom_plugins = {
  'atom-beautify' => '0.29.24',
  'minimap' => '4.28.2',
  'language-chef' => '0.9.0'
}

# ensure we have the required gui packages for starting atom in docker / Circle CI
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
    group vm_user
    mode '0664'
  end
end
