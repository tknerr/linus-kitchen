
# download and install golang
golang_version = node.fetch("golang_version", "")
golang_checksum = node.fetch("golang_checksum", "")
install_dir = "/usr/local"

remote_file "#{Chef::Config[:file_cache_path]}/go#{golang_version}.linux-amd64.tar.gz" do
  source "https://dl.google.com/go/go#{golang_version}.linux-amd64.tar.gz"
  checksum golang_checksum
  mode "0644"
  notifies :run, "bash[install-golang]", :immediately
  not_if "#{install_dir}/go/bin/go version | grep \"go#{golang_version} \""
end

bash "install-golang" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    rm -rf go
    rm -rf #{install_dir}/go
    tar -C #{install_dir} -xzf go#{golang_version}.linux-amd64.tar.gz
  EOH
  action :nothing
end

template "/etc/profile.d/golang.sh" do
  source "golang.sh.erb"
  owner "root"
  group "root"
  mode 0644
end

bashrc_manager "go env variables" do
  user vm_user
  content IO.read("#{run_context.cookbook_collection[cookbook_name].root_dir}/files/default/go_env")
end

# install go packages
go_packages = node.fetch("golang_packages", [])
go_packages.each do |package|
  install_go_package package
end
