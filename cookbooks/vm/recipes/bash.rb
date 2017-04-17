
#
# setup .bash.d for the vm user
#
bashd vm_user

bashd_entry 'shell-aliases' do
  user vm_user
  content 'alias be="bundle exec"'
end
