
node.set[:vagrant][:url] = "https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.2_x86_64.deb"
node.set[:vagrant][:checksum] = "e81f8c0df158a25efafda5895b2e2be39ce716f3b8eea0fccad990c29bc90fc0"
include_recipe "vagrant"

install_vagrant_plugin "vagrant-cachier", "1.1.0"
install_vagrant_plugin "vagrant-berkshelf", "4.0.2"
install_vagrant_plugin "vagrant-omnibus", "1.4.1"
install_vagrant_plugin "vagrant-lxc", "1.0.1"
install_vagrant_plugin "vagrant-toplevel-cookbooks", "0.2.3"

bash_profile "set-vagrant-default-provider" do
  user devbox_user
  content "export VAGRANT_DEFAULT_PROVIDER=lxc"
end

bash "add vagrant-lxc sudoers permissions" do
  environment devbox_user_env
  code "vagrant lxc sudoers"
  not_if { ::File.exists? "/etc/sudoers.d/vagrant-lxc" }
end

