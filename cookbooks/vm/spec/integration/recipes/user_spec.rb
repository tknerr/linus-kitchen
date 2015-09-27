require 'spec_helper'

describe 'vm::user' do

  it 'creates the devbox user' do
    expect(user('vagrant')).to exist
  end

  it 'adds the devbox user to the devbox group' do
    expect(user('vagrant')).to belong_to_group 'vagrant'
  end

  it 'adds the devbox user to sudoers' do
    expect(command('sudo -u vagrant bash -l -c "sudo echo lalala"').stdout).to contain 'lalala'
  end

  it 'sets up the devbox user\'s home directory' do
    expect(file('/home/vagrant')).to be_directory
    expect(user('vagrant')).to have_home_directory '/home/vagrant'
  end

  it 'sets up bash as the login shell for the devbox user' do
    expect(user('vagrant')).to have_login_shell '/bin/bash'
  end
end
