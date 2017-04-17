require 'serverspec'

set :backend, :exec

# the user account under which the VM is set up
def vm_user
  'linus'
end

# the configured vm user's home directory
def vm_user_home
  "home/#{vm_user}"
end

# run the given command in the same environment as if you were logged in to the VM
def vm_user_command(cmd)
  command("sudo -u #{vm_user} bash -i -c '#{cmd}; exit $?'")
end

# for runnig commands which expect an X environment
def vm_user_gui_command(cmd)
  vm_user_command "xvfb-run #{cmd}"
end

# see https://github.com/sethvargo/chef-sugar/blob/v3.4.0/lib/chef/sugar/docker.rb#L31
def in_docker?
  command('sudo test -f /.dockerinit || sudo test -f /.dockerenv').exit_status == 0
end

# see https://github.com/sethvargo/chef-sugar/blob/v3.4.0/lib/chef/sugar/virtualization.rb#L71
def in_vmware?
  command('sudo ohai virtualization | grep -q \'"system": "vmware"\'').exit_status == 0
end
