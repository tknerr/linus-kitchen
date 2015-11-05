require 'spec_helper'

describe 'vm::docker' do

  it 'installs docker 1.8.1' do
    expect(devbox_user_command('docker -v').stdout).to match 'Docker version 1.8.1'
  end

  it 'adds the devbox user to the docker group' do
    expect(devbox_user_command('sg docker -c "id"').stdout).to match(/groups=.*\(docker\)/)
  end

  it 'allows to run docker commands without sudo' do
    expect(devbox_user_command('sg docker -c "docker ps"').stdout).to contain 'CONTAINER ID'
  end
end
