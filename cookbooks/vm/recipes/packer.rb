
include_recipe 'ark'

packer_version = '1.0.0'
packer_checksum = 'ed697ace39f8bb7bf6ccd78e21b2075f53c0f23cdfb5276c380a053a7b906853'

ark 'packer' do
  url "https://releases.hashicorp.com/packer/#{packer_version}/packer_#{packer_version}_linux_amd64.zip"
  version packer_version
  checksum packer_checksum
  has_binaries ['packer']
  append_env_path false
  strip_components 0
  action :install
end
