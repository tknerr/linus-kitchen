
#
# setup .bash.d for the devbox user
#
bashd devbox_user

bashd_entry "shell-aliases" do
  user devbox_user
  content 'alias be="bundle exec"'
end
