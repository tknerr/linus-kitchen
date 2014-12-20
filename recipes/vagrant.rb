

node.set[:vagrant][:url] = "https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.1_x86_64.deb"
node.set[:vagrant][:checksum] = "6615b95fcd8044e2f5e1849ec1004df5e05e390812558ec2c4b3dcec541b92da"
include_recipe "vagrant"

# XXX: consider using vagrant_plugin LWRP
bash "setup the bindler vagrant plugin" do
  user node['devbox']['user']
  group node['devbox']['group']
  environment "HOME" => "/home/#{node['devbox']['user']}"
  code <<-EOH
  if ! $(vagrant plugin list | grep -q 'bindler'); then
    vagrant plugin install bindler --plugin-version 0.1.3
    vagrant bindler setup
  fi
  EOH
end

