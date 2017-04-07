
# add the docker apt repository
include_recipe 'chef-apt-docker'

# install docker and start the docker deamon
docker_service 'default' do
  install_method 'package'
  version '1.11.0'
  package_options "--force-yes -o Dpkg::Options::='--force-confold' -o Dpkg::Options::='--force-all'"
  service_manager docker? ? 'execute' : 'systemd'
  action [:create, :start]
end

# create the docker group and add the devbox_user to it
group 'docker' do
  action :create
  members devbox_user
  append true
  notifies :restart, 'docker_service[default]', :immediately
end
