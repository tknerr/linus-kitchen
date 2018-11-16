
#
# return a minimal sane environment for the vm user to be used in bash resources
# see https://tickets.opscode.com/browse/CHEF-2288
#
def vm_user_env
  {
    'HOME' => vm_user_home,
    'USER' => vm_user
  }
end

def vm_user
  ENV['SUDO_USER']
end

def vm_group
  vm_user
end

def vm_user_home
  "/home/#{vm_user}"
end

#
# reopen the Chef::Recipe class for being able to use it like any other resource
#
class Chef
  class Recipe
    #
    # workaround until the `vagrant_plugin` provider of the `vagrant` cookbook
    # supports passing the VAGRANT_HOME environment
    #
    def install_vagrant_plugin(name, version)
      bash "install vagrant plugin #{name}-#{version} for #{vm_user}" do
        user vm_user
        group vm_group
        environment vm_user_env
        code "vagrant plugin install #{name} --plugin-version #{version}"
        not_if "vagrant plugin list | grep -q '#{name} (#{version})'",
               user: vm_user,
               group: vm_group,
               environment: vm_user_env
      end
    end

    #
    # atom_apm does not work, so we use a bash resource, see
    # https://github.com/mohitsethi/chef-atom/issues/2
    #
    def install_atom_plugin(name, version)
      bash "install atom plugin #{name}@#{version} for #{vm_user}" do
        user vm_user
        group vm_group
        environment vm_user_env
        code "apm install #{name}@#{version}"
        not_if "apm list --installed --bare | grep -q '#{name}@#{version}'",
               user: vm_user,
               group: vm_group,
               environment: vm_user_env
      end
    end

    #
    # install a (system wide) pip package
    #
    def install_pip_package(name, version)
      bash "install pip package #{name}-#{version} for #{vm_user}" do
        code "pip install #{name}==#{version}"
        not_if "pip freeze | grep -q '#{name}==#{version}'"
      end
    end
  end
end
