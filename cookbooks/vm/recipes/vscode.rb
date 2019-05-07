
vscode_version = '1.33.1-1554971066'

vscode_plugins = {
  'bbenoist.vagrant' => '0.5.0',
  'dhoeric.ansible-vault' => '0.1.3',
  'donjayamanne.githistory' => '0.4.6',
  'eamodio.gitlens' => '9.6.3',
  'felipecaputo.git-project-manager' => '1.7.1',
  'mde.select-highlight-minimap' => '0.0.8',
  'ms-python.python' => '2019.4.11987',
  'ms-vscode.sublime-keybindings' => '4.0.0',
  'Pendrica.chef' => '0.7.1',
  'PeterJausovec.vscode-docker' => '0.6.1',
  'vscoss.vscode-ansible' => '0.5.2',
  'yzhang.markdown-all-in-one' => '2.3.1',
  'zikalino.azure-rest-for-ansible' => '0.0.18',
}

apt_repository 'vscode' do
  uri          'https://packages.microsoft.com/repos/vscode/'
  arch         'amd64'
  distribution 'stable'
  components   ['main']
  key          'https://packages.microsoft.com/keys/microsoft.asc'
end

package 'code' do
  version vscode_version
  action :install
end

# install vscode plugins
vscode_plugins.each do |name, version|
  install_vscode_plugin(name, version)
end
