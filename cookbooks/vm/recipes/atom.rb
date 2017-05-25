
atom_version = '1.17.1'
atom_deb_file = "atom-v#{atom_version}-amd64.deb"

atom_plugins = {
  'atom-beautify' => '0.29.24',
  'minimap' => '4.28.2',
  'language-chef' => '0.9.0'
}

if docker?
  # we need libxss-dev for starting atom in docker
  package 'libxss-dev'
  # avoid /dev/fuse issues on circleci
  extra_options = '--no-install-recommends'
end

# install atom editor
remote_file "#{Chef::Config[:file_cache_path]}/#{atom_deb_file}" do
  source "https://github.com/atom/atom/releases/download/v#{atom_version}/atom-amd64.deb"
  mode '0644'
end
bash 'install-atom-with-dependencies' do
  code <<-EOF
    dpkg -i #{Chef::Config[:file_cache_path]}/#{atom_deb_file}
    apt-get -y --fix-broken install #{extra_options}
    EOF
  not_if "which atom && xvfb-run atom -v | grep -q '#{atom_version}'"
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
