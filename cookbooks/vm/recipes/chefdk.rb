
bashd_entry 'chefdk-shell-init' do
  user vm_user
  content 'eval "$(chef shell-init bash)"'
end

directory "#{vm_userhome}/.bundle" do
  owner vm_user
  group vm_group
  mode '0755'
  action :create
end

template "#{vm_userhome}/.bundle/config" do
  source 'bundler_config.erb'
  owner vm_user
  group vm_group
  mode '0644'
end
