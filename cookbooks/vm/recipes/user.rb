
group devbox_group do
  action :create
end

user devbox_user do
  action :create
  gid devbox_group
  home devbox_userhome
  shell '/bin/bash'
  password `openssl passwd -1 "#{devbox_password}"`.strip # ~FC048
  supports manage_home: true
end

# XXX: consider using sudo cookbook
group 'sudo' do
  action :modify
  members devbox_user
  append true
end
