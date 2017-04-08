require 'spec_helper'

describe 'update-vm.sh' do
  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html

  it 'installs git' do
    expect(package('git')).to be_installed
    expect(command('git --version').exit_status).to eq 0
  end

  it 'installs chefdk 1.3.32' do
    expect(command('chef --version').stdout).to contain 'Chef Development Kit Version: 1.3.32'
  end
end
