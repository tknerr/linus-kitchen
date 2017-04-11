
node.set['packer']['version'] = '1.0.0'
node.set['packer']['checksum'] = 'ed697ace39f8bb7bf6ccd78e21b2075f53c0f23cdfb5276c380a053a7b906853'

# XXX: need to explicitly repeat the computed attributes here, otherwise they will see stale values
# see discussion here: http://lists.opscode.com/sympa/arc/chef/2015-06/msg00203.html
node.set['packer']['url_base'] = "https://releases.hashicorp.com/packer/#{node['packer']['version']}"
node.set['packer']['zipfile'] = "packer_#{node['packer']['version']}_#{node['os']}_#{node['packer']['arch']}.zip"

include_recipe 'sbp_packer'
