
# XXX: consider using chef-rvm or rubybuild cookbook
%w{ ruby1.9.1 build-essential libxslt-dev libxml2-dev }.each do |pkg|
  package pkg
end

gem_package "bundler"