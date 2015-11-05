require 'serverspec'

set :backend, :exec

# run the given command in the same environment as if you were logged in to the VM
def devbox_user_command(cmd)
  command("sudo -u vagrant bash -i -c '#{cmd}; exit $?'")
end
