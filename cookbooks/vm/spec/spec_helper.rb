require 'serverspec'

set :backend, :exec

#
# return the user under which we assume the user would be logged in
#
def devbox_user
  'vagrant'
end
