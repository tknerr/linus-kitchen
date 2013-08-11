
# see https://gist.github.com/fgrehm/b07c6370a710be622807#file-02-ubuntu-vagrantfile-rb

%w{ lxc redir htop btrfs-tools apparmor-utils linux-image-generic linux-headers-generic }.each do |pkg|
  package pkg
end

bash "sudo aa-complain /usr/bin/lxc-start"

# XXX: should be installed per-project via bindler!
install_vagrant_plugin "vagrant-lxc", "0.5.0"

