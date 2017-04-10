
atom_version = '1.15.0'
atom_deb_file = "atom-v#{atom_version}-amd64.deb"

if docker?
  # we need libasound2 for starting atom in docker
  package 'libasound2'
  # avoid /dev/fuse issues on circleci
  extra_options = '--no-install-recommends'
end

# install atom
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

# install plugins
plugins = {
  'atom-beautify' => '0.29.18',
  'minimap' => '4.27.1',
  'language-chef' => '0.9.0',
  'language-batchfile' => '0.4.0'
}
plugins.each do |name, version|
  install_atom_plugin(name, version)
end

# config tweaks
template "#{devbox_userhome}/.atom/config.cson" do
  source 'atom_config.erb'
  owner devbox_user
  group devbox_user
  mode '0664'
end
