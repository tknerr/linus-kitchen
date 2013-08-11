
include_recipe "apt"

%w{ vim git }.each do |pkg|
  package pkg
end