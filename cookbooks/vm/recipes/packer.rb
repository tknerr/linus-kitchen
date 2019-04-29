
include_recipe 'ark'

packer_version = '1.4.0'
packer_checksum = '7505e11ce05103f6c170c6d491efe3faea1fb49544db0278377160ffb72721e4'

ark 'packer' do
  url "https://releases.hashicorp.com/packer/#{packer_version}/packer_#{packer_version}_linux_amd64.zip"
  version packer_version
  checksum packer_checksum
  has_binaries ['packer']
  append_env_path false
  strip_components 0
  action :install
end
