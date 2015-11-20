
#
# manually restore a good bundler version until chef/omnibus-chef#464 is fixed
#
bash 'fix-bundler-in-chefdk' do
  environment devbox_user_env
  user devbox_user
  group devbox_group
  code 'chef gem install bundler --version=1.10.6 --no-ri --no-rdoc'
  not_if 'chef gem list bundler | grep 1.10.6',
         environment: devbox_user_env,
         user: devbox_user,
         group: devbox_group
end
ruby_block 'fix-bundler-in-vagrant-gemspec' do
  block do
    gemspec = '/opt/vagrant/embedded/gems/gems/vagrant-1.7.4/vagrant.gemspec'
    gemspec2 = '/opt/vagrant/embedded/gems/specifications/vagrant-1.7.4.gemspec'
    File.write(gemspec, File.read(gemspec).gsub('1.10.5', '1.10.6'))
    File.write(gemspec2, File.read(gemspec2).gsub('1.10.5', '1.10.6'))
  end
  action :run
end
