

node.set[:vagrant][:url] = "http://files.vagrantup.com/packages/7ec0ee1d00a916f80b109a298bab08e391945243/vagrant_1.2.7_x86_64.deb"
node.set[:vagrant][:checksum] = "4e6cbbe820fd096355eb0e878436fa3c6468ae5969c60f2a8a3ceb6ec6059c5e"
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

