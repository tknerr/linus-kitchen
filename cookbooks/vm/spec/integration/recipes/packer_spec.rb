require 'spec_helper'

describe 'vm::packer' do

  let(:packer_version) { devbox_user_command('packer -v').stdout.strip }

  it 'installs packer 1.0.0' do
    expect(packer_version).to eq '1.0.0'
  end
end
