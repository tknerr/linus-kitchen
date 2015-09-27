
include_recipe 'apt'

%w( vim git libxml2-dev libxslt1-dev zlib1g-dev liblzma-dev ).each do |pkg|
  package pkg
end
