
#
# XXX: use minitest-handler or equivalent!
#
ruby_block "test if dev-box is OK :-)" do
  block do
    raise "wrong ruby!" unless `ruby -v`.include? "1.9.3"       
  end
end


#
# see https://github.com/fgrehm/vagrant-lxc/wiki/Base-boxes#available-boxes
#
=begin
Vagrant.configure("2") do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://bit.ly/vagrant-lxc-precise64-2013-07-12"
end

dann `vagrant up --provider=lxc`
=end
