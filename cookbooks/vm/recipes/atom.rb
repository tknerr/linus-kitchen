
# sets up ppa launchpad repo
include_recipe 'atom'

if docker?
  # we need xvfb + libasound2 for starting atom in docker
  package 'xvfb'
  package 'libasound2'
  # avoid /dev/fuse issues on circleci
  extra_options = '--no-install-recommends'
end

# install atom
package 'atom' do
  action :install
  version '1.3.0-1~webupd8~0'
  options extra_options || ''
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
