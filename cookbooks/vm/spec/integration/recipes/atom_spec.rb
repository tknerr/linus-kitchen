require 'spec_helper'

describe 'vm::atom' do

  let(:atom_version) { vm_user_gui_command('atom -v').stdout }
  let(:atom_config) { file("#{vm_user_home}/.atom/config.cson") }
  let(:installed_plugins) { vm_user_command('apm list -i -b').stdout }

  it 'installs atom 1.17.1' do
    expect(atom_version).to contain '1.17.1'
  end

  describe 'plugins' do
    it 'installs "atom-beautify" plugin v0.29.24' do
      expect(installed_plugins).to contain 'atom-beautify@0.29.24'
    end
    it 'installs "minimap" plugin v4.28.2' do
      expect(installed_plugins).to contain 'minimap@4.28.2'
    end
    it 'installs "language-chef" plugin v0.9.0' do
      expect(installed_plugins).to contain 'language-chef@0.9.0'
    end
    it 'installs "language-ansible" plugin v0.2.1' do
      expect(installed_plugins).to contain 'language-ansible@0.2.1'
    end
  end

  it 'configures atom to have sublime tabs behaviour' do
    expect(atom_config).to contain 'usePreviewTabs: true'
  end
  it 'configures atom to show invisible characters' do
    expect(atom_config).to contain 'showInvisibles: true'
  end
end
