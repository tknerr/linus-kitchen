require 'spec_helper'

describe 'vm::virtualbox' do

  let(:virtualbox_version) { devbox_user_command('vboxmanage --version').stdout.strip }

  it 'installs VirtualBox 5.1.18' do
    expect(virtualbox_version).to match '5.1.18'
  end
end
