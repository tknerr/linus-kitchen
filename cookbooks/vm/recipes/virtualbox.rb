
apt_repository "virtualbox" do
  uri "https://download.virtualbox.org/virtualbox/debian"
  distribution "bionic"
  components ["contrib"]
  key "https://www.virtualbox.org/download/oracle_vbox_2016.asc"
  arch "amd64"
  action :add
end

vbox_version = node.fetch("vbox_version", "")
package "virtualbox-6.0" do
  options "--allow-change-held-packages --allow-downgrades"
  version vbox_version
  action :install
end
