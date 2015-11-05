
include_recipe 'chef-sugar'

# the chef-sugar gem files would be owned by root otherwise
execute 'fix-chef-sugar-file-permissions' do
  command "sudo chown -R #{devbox_user}:#{devbox_group} #{devbox_userhome}/.chefdk"
end

include_recipe 'apt'

%w( vim git libxml2-dev libxslt1-dev zlib1g-dev liblzma-dev ).each do |pkg|
  package pkg
end
