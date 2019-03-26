
# install required dependencies
package ["python-pip", "libssl-dev", "libffi-dev"]

# install ansible
version = node.fetch("ansible_version", "")
install_pip_package "ansible", version

# install testinfra with the spec formatter, and molecule
node.fetch("ansible_plugins", []).each do |plugin|
  install_pip_package plugin["name"], plugin["version"]
end
