require 'spec_helper'

describe 'update-vm.sh' do
  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html

  it 'installs git' do
    expect(package('git')).to be_installed
    expect(command('git --version').exit_status).to eq 0
  end

  it 'installs chefdk 0.13.21' do
    expect(command('chef --version').stdout).to contain 'Chef Development Kit Version: 0.13.21'
  end
end
