
docker_version = '18.09.5'

# create the docker group and add the vm_user to it
group 'docker' do
  action :create
  members vm_user
  append true
end

# install docker and start the docker deamon
docker_service 'default' do
  install_method 'package'
  version docker_version
  action [:create, :start]
end

