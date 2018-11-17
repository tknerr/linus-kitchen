
vscode_version = "1.29.1-1542309157"

apt_repository "vscode" do
  uri "https://packages.microsoft.com/repos/vscode"
  distribution "stable"
  components ["main"]
  key "https://packages.microsoft.com/keys/microsoft.asc"
  arch "amd64"
  action :add
end

# if docker?
#  package ["libcanberra-gtk-module", "libgconf-2-4", "libasound2", "libgtk2.0-0", "libxss1"]
# end

package "code" do
  options "--allow-change-held-packages --allow-downgrades"
  version vscode_version
  action :install
end

# install plugins
plugins = [
  "robertohuertasm.vscode-icons",
  "eamodio.gitlens",
  "rebornix.ruby",
  "castwide.solargraph",
  "mbessey.vscode-rufo",
  "Pendrica.chef",
  "bbenoist.vagrant",
  "PeterJausovec.vscode-docker",
]

plugins.each do |plugin|
  install_vscode_plugin(plugin)
end

# install gems
gems = {
  "rufo" => "0.4.0",
  "solargraph" => "0.28.2",
}

gems.each do |gem, version|
  install_gem_package(gem, version)
end

# config tweaks
cookbook_file "#{vm_user_home}/.config/Code/User/settings.json" do
  source "vscode_settings.json"
  owner vm_user
  group vm_group
  mode "0664"
end
