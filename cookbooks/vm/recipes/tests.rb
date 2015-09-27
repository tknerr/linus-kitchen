#
# XXX: use minitest-handler or equivalent!
#

results = '/tmp/output.txt'
file results do
  action :delete
end

bash 'list environment' do
  user node['devbox']['user']
  group node['devbox']['group']
  environment devbox_user_env
  code <<-EOH
  {
    echo "I am: `whoami`"
    echo "..and my HOME is: `echo $HOME`"
    echo "These are my tools:"
    echo `vagrant -v`
    echo `vagrant plugin list`
    echo `chef -v`
  } > #{results}
  EOH
end

ruby_block 'print results' do
  only_if { ::File.exist?(results) }
  block do
    puts File.read(results)
  end
end

#
# see https://github.com/fgrehm/vagrant-lxc/wiki/Base-boxes#available-boxes
#
# Vagrant.configure("2") do |config|
#   config.vm.box = "precise64"
#   config.vm.box_url = "http://bit.ly/vagrant-lxc-precise64-2013-07-12"
# end
#
# dann `vagrant up --provider=lxc`
