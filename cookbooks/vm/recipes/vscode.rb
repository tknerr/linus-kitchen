
apt_repository "vscode" do
  uri "https://packages.microsoft.com/repos/vscode"
  distribution "stable"
  components ["main"]
  key "https://packages.microsoft.com/keys/microsoft.asc"
  arch "amd64"
  action :add
end

vscode_version = node.fetch("vscode_version", "")
package "code" do
  options "--allow-change-held-packages --allow-downgrades"
  version vscode_version
  action :install
end

# install plugins
plugins = node.fetch("vscode_plugins", [])
plugins.each do |plugin|
  install_vscode_plugin(plugin)
end

# install gems
gems = node.fetch("vscode_gems", [])
gems.each do |gem|
  install_gem_package(gem["name"], gem["version"])
end

# config tweaks
cookbook_file "#{vm_user_home}/.config/Code/User/settings.json" do
  source "vscode_settings.json"
  owner vm_user
  group vm_group
  mode "0664"
end
