
node.set[:vagrant][:url] = "https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.1_x86_64.deb"
node.set[:vagrant][:checksum] = "6615b95fcd8044e2f5e1849ec1004df5e05e390812558ec2c4b3dcec541b92da"
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

# XXX - fix for https://github.com/mitchellh/vagrant/issues/5001
remote_file "/opt/vagrant/embedded/cacert.pem" do
  action :create_if_missing
  source "https://gist.githubusercontent.com/tknerr/71fc51b591db47541a46/raw/cacert.pem"
end
