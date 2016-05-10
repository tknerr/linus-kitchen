require 'spec_helper'
require 'chef/sugar/docker'

describe 'vm::atom' do

  # simulate an X environment in docker / circleci
  atom_version_cmd = if Chef::Sugar::Docker.docker?(@node)
                       'xvfb-run atom -v'
                     else
                       'DISPLAY=:0 atom -v'
                     end

  let(:atom_version) { devbox_user_command(atom_version_cmd).stdout.strip }
  let(:atom_config) { file('/home/vagrant/.atom/config.cson') }
  let(:installed_plugins) { devbox_user_command('apm list -i').stdout }

  it 'installs atom 1.3.1' do
    expect(atom_version).to eq '1.3.1'
  end

  it 'installs some useful atom plugins' do
    expect(installed_plugins).to contain 'atom-beautify'
    expect(installed_plugins).to contain 'minimap'
    expect(installed_plugins).to contain 'line-ending-converter'
    expect(installed_plugins).to contain 'language-chef'
    expect(installed_plugins).to contain 'language-batchfile'
  end

  it 'configures atom to have sublime tabs behaviour' do
    expect(atom_config).to contain 'usePreviewTabs: true'
  end
  it 'configures atom to show invisible characters' do
    expect(atom_config).to contain 'showInvisibles: true'
  end
  it 'configures atom to use the "atom-dark" theme' do
    expect(atom_config).to contain '"atom-dark-ui"'
    expect(atom_config).to contain '"atom-dark-syntax"'
  end
end
