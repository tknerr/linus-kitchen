require 'serverspec'

set :backend, :exec

# run the given command in the same environment as if you were logged in to the VM
def devbox_user_command(cmd)
  command("sudo -u vagrant bash -i -c '#{cmd}; exit $?'")
end

# for runnig commands which expect an X environment
def devbox_user_gui_command(cmd)
  if in_docker?
    devbox_user_command "xvfb-run #{cmd}"
  else
    devbox_user_command "DISPLAY=:0 #{cmd}"
  end
end

# see https://github.com/sethvargo/chef-sugar/blob/v3.4.0/lib/chef/sugar/docker.rb#L31
def in_docker?
  command('sudo test -f /.dockerinit || sudo test -f /.dockerenv').exit_status == 0
end

# see https://github.com/sethvargo/chef-sugar/blob/v3.4.0/lib/chef/sugar/virtualization.rb#L71
def in_vmware?
  command('sudo ohai virtualization | grep -q \'"system": "vmware"\'').exit_status == 0
end
