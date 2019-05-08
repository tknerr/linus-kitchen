
docker_version = '18.09.5'

# create the docker group and add the vm_user to it
group 'docker' do
  action :create
  members vm_user
  append true
end

# install docker CLI and deamon packages
docker_installation_package 'default' do
  package_name 'docker-ce-cli'
  version docker_version
  action :create
end
docker_installation_package 'default' do
  package_name 'docker-ce'
  version docker_version
  action :create
end

# install docker daemon as a service
docker_service_manager_systemd 'default' do
  action :start
end

