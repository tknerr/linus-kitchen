class Chef
  class Recipe
    #
    # workaround until the `vagrant_plugin` provider of the `vagrant` cookbook
    # supports passing the VAGRANT_HOME environment
    #
    def install_vagrant_plugin(name, version)
      bash "install vagrant plugin #{name}-#{version} for #{node['devbox']['user']}" do
        user node['devbox']['user']
        group node['devbox']['group']
        environment "HOME" => "/home/#{node['devbox']['user']}"
        code <<-EOH
        if ! $(vagrant plugin list | grep -q '#{name} (#{version})'); then
          vagrant plugin install #{name} --plugin-version #{version}
        fi
        EOH
      end
    end
  end
end