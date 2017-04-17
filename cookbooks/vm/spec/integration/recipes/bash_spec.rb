require 'spec_helper'

describe 'vm::bash' do

  it 'sets up the .bash.d/ directory for the vm user' do
    expect(file("/home/#{vm_user}/.bash.d")).to be_directory
    expect(file("/home/#{vm_user}/.bash.d")).to be_owned_by vm_user
  end

  it 'sets up shell alias `be` => `bundle exec` for the devbox user' do
    expect(devbox_user_command('be').stdout).to contain 'bundler: exec needs a command to run'
  end
end
