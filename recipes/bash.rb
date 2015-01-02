
#
# Ubuntu uses ~/.profile usually, but when ~/.bash_profile
# is present only the latter one would be used instead.
#
bash_profile "source-dot-profile" do
  user devbox_user
  content "source ~/.profile"
end