require 'spec_helper'

describe 'vm::user' do

  it 'creates the vagrant user' do
    expect(user('vagrant')).to exist
  end

  it 'adds the vagrant user to the vagrant group' do
    expect(user('vagrant')).to belong_to_group 'vagrant'
  end

  it 'sets up the vagrant user\'s home directory' do
    expect(file('/home/vagrant')).to be_directory
    expect(user('vagrant')).to have_home_directory '/home/vagrant'
  end

  it 'sets up bash as the login shell for the vagrant user' do
    expect(user('vagrant')).to have_login_shell '/bin/bash'
  end

  it 'adds the vagrant user to sudoers' do
    expect(command('sudo -u vagrant bash -l -c "sudo echo lalala"').stdout).to contain 'lalala'
  end
end
