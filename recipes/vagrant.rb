
node.set[:vagrant][:url] = "https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.2_x86_64.deb"
node.set[:vagrant][:checksum] = "9d7f1c587134011e2d5429eb21b6c0e95487f52e6d6d47c03ecc82cbeee73968"

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

template "#{devbox_userhome}/.vagrant.d/Vagrantfile" do
  source "Vagrantfile.erb"
  owner devbox_user
  group devbox_group
  mode "0644"
end

