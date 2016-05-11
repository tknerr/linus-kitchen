require 'serverspec'

set :backend, :exec

# run the given command in the same environment as if you were logged in to the VM
def devbox_user_command(cmd)
  command("sudo -u vagrant bash -i -c '#{cmd}; exit $?'")
end

# for runnig commands which expect an X environment
def devbox_user_gui_command(cmd)
  if Chef::Sugar::Docker.docker?(@node)
    devbox_user_command "xvfb-run #{cmd}"
  else
    devbox_user_command "DISPLAY=:0 #{cmd}"
  end
end
