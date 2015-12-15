
package 'git' do
  action :install
end

package 'meld' do
  action :install
end

template "#{devbox_userhome}/.gitconfig" do
  source 'git_config.erb'
  owner devbox_user
  group devbox_group
  mode '0644'
end
