
# add the docker apt repository
include_recipe 'chef-apt-docker'

# create the docker group and add the devbox_user to it
group 'docker' do
  action :create
  members devbox_user
  append true
end

# FIXME: running docker-in-docker-in-docker still fails on circleci, so we skip
# starting the deamon on circleci for now
if docker?
  # only install docker, don't try to start the deamon
  docker_installation_package 'default' do
    version '1.11.0'
    action :create
  end
else
  # install docker and start the docker deamon
  docker_service 'default' do
    install_method 'package'
    version '1.11.0'
    action [:create, :start]
  end
end
