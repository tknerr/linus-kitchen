require 'spec_helper'

describe 'vm::atom' do

  let(:atom_version) { devbox_user_gui_command('atom -v').stdout }
  let(:atom_config) { file("/home/#{vm_user}/.atom/config.cson") }
  let(:installed_plugins) { devbox_user_command('apm list -i -b').stdout }

  it 'installs atom 1.15.0' do
    expect(atom_version).to contain '1.15.0'
  end

  describe 'plugins' do
    it 'installs "atom-beautify" plugin v0.29.18' do
      expect(installed_plugins).to contain 'atom-beautify@0.29.18'
    end
    it 'installs "minimap" plugin v4.27.1' do
      expect(installed_plugins).to contain 'minimap@4.27.1'
    end
    it 'installs "language-chef" plugin v0.9.0' do
      expect(installed_plugins).to contain 'language-chef@0.9.0'
    end
  end

  it 'configures atom to have sublime tabs behaviour' do
    expect(atom_config).to contain 'usePreviewTabs: true'
  end
  it 'configures atom to show invisible characters' do
    expect(atom_config).to contain 'showInvisibles: true'
  end
end
