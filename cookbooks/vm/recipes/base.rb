
include_recipe 'apt'
include_recipe 'chef-sugar'

%w(vim git libxml2-dev libxslt1-dev zlib1g-dev liblzma-dev build-essential xvfb indicator-multiload).each do |pkg|
  package pkg
end
