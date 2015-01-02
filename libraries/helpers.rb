class Chef
  class Recipe
    #
    # workaround until the `vagrant_plugin` provider of the `vagrant` cookbook
    # supports passing the VAGRANT_HOME environment
    #
    def install_vagrant_plugin(name, version)
      env = {
        HOME => "/home/#{node['devbox']['user']}"
      }
      bash "install vagrant plugin #{name}-#{version} for #{node['devbox']['user']}" do
        user node['devbox']['user']
        group node['devbox']['group']
        environment env
        code "vagrant plugin install #{name} --plugin-version #{version}"
        not_if "vagrant plugin list | grep -q '#{name} (#{version})'", :environment => env
      end
    end
  end
end