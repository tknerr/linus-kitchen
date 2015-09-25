
# sets up ppa launchpad repo
include_recipe "atom"

# install atom
package "atom" do
  action :install
end

# currently disabled, see https://github.com/mohitsethi/chef-atom/issues/2
=begin
# install plugins
atom_apm "minimap"
atom_apm "file-icons"
atom_apm "autocomplete-plus"
=end
