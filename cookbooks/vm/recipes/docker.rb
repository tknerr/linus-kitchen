
# installer the docker daemon
docker_service 'default' do
  version '1.11'
  action [:create, :start]
end

# create the docker group and add the devbox_user to it
group 'docker' do
  action :create
  members devbox_user
  append true
  notifies :restart, 'docker_service[default]', :immediately
end
