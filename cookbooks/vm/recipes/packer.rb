
include_recipe 'ark'

packer_version = node.fetch("packer_version", "")
packer_checksum = node.fetch("packer_checksum", "")

ark 'packer' do
  url "https://releases.hashicorp.com/packer/#{packer_version}/packer_#{packer_version}_linux_amd64.zip"
  version packer_version
  checksum packer_checksum
  has_binaries ['packer']
  append_env_path false
  strip_components 0
  action :install
end
