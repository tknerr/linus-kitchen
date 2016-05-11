require 'spec_helper'
require 'chef/sugar/docker'

describe 'vm::atom' do

  let(:atom_version) { devbox_user_gui_command('atom -v').stdout }
  let(:atom_config) { file('/home/vagrant/.atom/config.cson') }
  let(:installed_plugins) { devbox_user_command('apm list -i -b').stdout }

  it 'installs atom 1.7.3' do
    expect(atom_version).to contain '1.7.3'
  end

  describe 'plugins' do
    it 'installs "atom-beautify" plugin v0.29.7' do
      expect(installed_plugins).to contain 'atom-beautify@0.29.7'
    end
    it 'installs "minimap" plugin v4.23.5' do
      expect(installed_plugins).to contain 'minimap@4.23.5'
    end
    it 'installs "line-ending-converter" plugin v1.3.2' do
      expect(installed_plugins).to contain 'line-ending-converter@1.3.2'
    end
    it 'installs "language-chef" plugin v0.9.0' do
      expect(installed_plugins).to contain 'language-chef@0.9.0'
    end
    it 'installs "language-batchfile" plugin v0.4.0' do
      expect(installed_plugins).to contain 'language-batchfile@0.4.0'
    end
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
