
#
# setup .bashrc.d for the vm user
#
bashrc_manager "shell-aliases" do
  user vm_user
  content 'alias be="bundle exec"'
end
