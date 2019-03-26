
# add the docker apt repository
include_recipe "chef-apt-docker"

docker_version = node.fetch("docker_version", "")

# create the docker group and add the vm_user to it
group "docker" do
  action :create
  members vm_user
  append true
end

# FIXME: running docker-in-docker-in-docker still fails so we skip starting the deamon in docker for now
if docker?
  # only install docker, don't try to start the deamon
  docker_installation_package "default" do
    version docker_version
    action :create
  end
else
  # install docker and start the docker deamon
  docker_service "default" do
    install_method "package"
    version docker_version
    action [:create, :start]
  end
end
