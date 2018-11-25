
# download and install atom editor
atom_version = node.fetch("atom_version", "")
atom_deb_file = "atom-v#{atom_version}-amd64.deb"
atom_checksum = node.fetch("atom_checksum", "")

if docker?
  package ["libnss3", "libxss1", "gvfs-bin", "xdg-utils"]
end

remote_file "#{Chef::Config[:file_cache_path]}/#{atom_deb_file}" do
  source "https://github.com/atom/atom/releases/download/v#{atom_version}/atom-amd64.deb"
  checksum atom_checksum
  mode "0644"
  notifies :install, "dpkg_package[atom]", :immediately
end

dpkg_package "atom" do
  source "#{Chef::Config[:file_cache_path]}/#{atom_deb_file}"
  version atom_version
end

# install atom plugins
atom_plugins = node.fetch("atom_plugins", [])
atom_plugins.each do |plugin|
  install_atom_plugin(plugin["name"], plugin["version"])
end

# config tweaks
["config.cson", "init.coffee"].each do |config|
  cookbook_file "#{vm_user_home}/.atom/#{config}" do
    source "atom_#{config}"
    owner vm_user
    group vm_group
    mode "0664"
  end
end
