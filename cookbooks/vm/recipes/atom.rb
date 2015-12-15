
# sets up ppa launchpad repo
include_recipe 'atom'

# ...skip this in docker containers due to permission issue with /dev/fuse
unless docker?

  # install atom
  package 'atom' do
    action :install
    version '1.3.0-1~webupd8~0'
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
end
