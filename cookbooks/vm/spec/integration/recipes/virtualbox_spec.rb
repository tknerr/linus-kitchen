require 'spec_helper'

describe 'vm::virtualbox' do

  let(:virtualbox_version) { vm_user_command('vboxmanage --version').stdout.strip }

  it 'installs VirtualBox 6.0.6' do
    expect(virtualbox_version).to match '6.0.6'
  end
end
