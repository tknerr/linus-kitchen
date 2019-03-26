
# install gems
gems = node.fetch("gems", [])
gems.each do |gem|
  install_gem_package(gem["name"], gem["version"])
end