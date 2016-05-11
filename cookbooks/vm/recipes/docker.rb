
# setup the apt repositories for docker
include_recipe 'apt-docker'

# install the docker-engine
docker_installation_package 'default' do
  version '1.11.0'
  action :create
  package_options "--force-yes -o Dpkg::Options::='--force-confold' -o Dpkg::Options::='--force-all'"
end

# start the docker deamon as a service
docker_service_manager 'default' do
  action :start
end

# create the docker group and add the devbox_user to it
group 'docker' do
  action :create
  members devbox_user
  append true
  notifies :restart, 'docker_service_manager[default]', :immediately
end
