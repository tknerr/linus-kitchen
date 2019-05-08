require 'spec_helper'

describe 'vm::docker' do

  it 'installs docker 18.09.5' do
    expect(vm_user_command('docker -v').stdout).to match 'Docker version 18.09.5'
  end

  it 'adds the vm user to the docker group' do
    expect(vm_user_command('sg docker -c "id"').stdout).to match(/groups=.*\(docker\)/)
  end

  it 'allows to run docker commands without sudo' do
    expect(vm_user_command('sg docker -c "docker ps"').stdout).to contain 'CONTAINER ID'
  end
end
