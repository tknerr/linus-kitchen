require "spec_helper"

describe "vm::docker", :"full-node" do
  it "installs docker 18.09.3" do
    expect(vm_user_command("docker -v").stdout).to match "18.09.3"
  end

  it "adds the vm user to the docker group" do
    expect(vm_user_command('sg docker -c "id"').stdout).to match(/groups=.*\(docker\)/)
  end

  # running docker-in-docker-in-docker still fails on circleci, so we skip it for now
  # see also:
  # - https://blog.docker.com/2013/09/docker-can-now-run-within-docker/
  # - https://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/
  unless in_docker?
    it "allows to run docker commands without sudo" do
      expect(vm_user_command('sg docker -c "docker ps"').stdout).to contain "CONTAINER ID"
    end
  end
end
