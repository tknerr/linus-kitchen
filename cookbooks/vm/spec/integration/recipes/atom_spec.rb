require 'spec_helper'
require 'chef/sugar/docker'

# installing atom on docker does not work, so we don't need to test either
unless Chef::Sugar::Docker.docker?(@node)

  describe 'vm::atom' do

    let(:atom_version) { devbox_user_command('atom -v').stdout.strip }
    let(:atom_config) { file('/home/vagrant/.atom/config.cson') }
    let(:installed_plugins) { devbox_user_command('apm list -i').stdout }

    it 'installs atom 1.2.1' do
      expect(atom_version).to eq '1.2.1'
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
end
