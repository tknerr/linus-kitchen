
node.set['chef_dk']['version'] = '0.3.5-1'
include_recipe "chef-dk"

bash_profile "chefdk-shell-init" do
  user devbox_user
  content %{eval "$(chef shell-init bash)"}
end