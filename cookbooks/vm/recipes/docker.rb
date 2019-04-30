
docker_version = '18.09.5'

# create the docker group and add the vm_user to it
group 'docker' do
  action :create
  members vm_user
  append true
end

# FIXME: running docker-in-docker-in-docker still fails on circleci, so we skip
# starting the deamon on circleci for now
if docker?
  # only install docker, don't try to start the deamon
  docker_installation_package 'default' do
    version docker_version
    action :create
  end
else
  # install docker and start the docker deamon
  docker_service 'default' do
    install_method 'package'
    version docker_version
    action [:create, :start]
  end
end
