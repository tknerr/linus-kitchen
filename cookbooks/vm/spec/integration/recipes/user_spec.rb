require 'spec_helper'

describe 'vm::user' do

  it 'creates the vm user' do
    expect(user(vm_user)).to exist
  end

  it 'adds the vm user to a group of the same name' do
    expect(user(vm_user)).to belong_to_group vm_user
  end

  it 'adds the vm user to sudoers' do
    expect(devbox_user_command('sudo echo lalala').stdout).to contain 'lalala'
  end

  it 'sets up the vm user\'s home directory' do
    expect(file("/home/#{vm_user}")).to be_directory
    expect(user(vm_user)).to have_home_directory "/home/#{vm_user}"
  end

  it 'sets up bash as the login shell for the vm user' do
    expect(user(vm_user)).to have_login_shell '/bin/bash'
  end
end
