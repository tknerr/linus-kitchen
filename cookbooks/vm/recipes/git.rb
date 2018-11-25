

package 'meld' do
  action :install
end

package 'git' do
  action :install
end

template "#{vm_user_home}/.gitconfig" do
  source 'git_config.erb'
  owner vm_user
  group vm_group
  mode '0644'
  action :create_if_missing
end

bashrc_manager 'setup-git-ps1-prompt' do
  user vm_user
  content IO.read("#{run_context.cookbook_collection[cookbook_name].root_dir}/files/default/git_ps1")
end
