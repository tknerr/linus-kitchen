
include_recipe 'ark'

packer_version = '1.3.2'
packer_checksum = '5e51808299135fee7a2e664b09f401b5712b5ef18bd4bad5bc50f4dcd8b149a1'

ark 'packer' do
  url "https://releases.hashicorp.com/packer/#{packer_version}/packer_#{packer_version}_linux_amd64.zip"
  version packer_version
  checksum packer_checksum
  has_binaries ['packer']
  append_env_path false
  strip_components 0
  action :install
end
