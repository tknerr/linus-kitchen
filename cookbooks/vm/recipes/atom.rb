
if docker?
  # we need xvfb + libasound2 for starting atom in docker
  package 'xvfb'
  package 'libasound2'
end

# install atom
remote_file "#{Chef::Config[:file_cache_path]}/atom-1.3.1-amd64.deb" do
  source 'https://github.com/atom/atom/releases/download/v1.3.1/atom-amd64.deb'
  mode 0644
end
dpkg_package 'atom' do
  source "#{Chef::Config[:file_cache_path]}/atom-1.3.1-amd64.deb"
  action :install
end

# install plugins
plugins = %w(
  atom-beautify
  minimap
  line-ending-converter
  language-chef
  language-batchfile
)
plugins.each do |plugin|
  # atom_apm does not work, so we use a bash resource, see
  # https://github.com/mohitsethi/chef-atom/issues/2
  bash "install-#{plugin}-atom-plugin" do
    environment devbox_user_env
    user devbox_user
    group devbox_group
    code "apm install #{plugin}"
  end
end

# config tweaks
template "#{devbox_userhome}/.atom/config.cson" do
  source 'atom_config.erb'
  owner devbox_user
  group devbox_user
  mode '0664'
end
