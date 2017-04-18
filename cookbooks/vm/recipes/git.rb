
if docker?
  # avoid /dev/fuse issues on circleci
  extra_options = '--no-install-recommends'
end

package 'meld' do
  action :install
  options extra_options || ''
end

package 'git' do
  action :install
end

template "#{devbox_userhome}/.gitconfig" do
  source 'git_config.erb'
  owner devbox_user
  group devbox_group
  mode '0644'
end

bashd_entry 'setup-git-ps1-prompt' do
  user devbox_user
  source 'git_ps1.erb'
end
