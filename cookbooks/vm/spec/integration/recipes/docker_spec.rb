require 'spec_helper'

describe 'vm::docker' do

  it 'installs docker 17.04.0-ce' do
    expect(devbox_user_command('docker -v').stdout).to match 'Docker version 17.04.0-ce'
  end

  it 'adds the devbox user to the docker group' do
    expect(devbox_user_command('sg docker -c "id"').stdout).to match(/groups=.*\(docker\)/)
  end

  # running docker-in-docker-in-docker still fails on circleci, so we skip it for now
  # see also:
  # - https://blog.docker.com/2013/09/docker-can-now-run-within-docker/
  # - https://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/
  unless in_docker?
    it 'allows to run docker commands without sudo' do
      expect(devbox_user_command('sg docker -c "docker ps"').stdout).to contain 'CONTAINER ID'
    end
  end
end
