require "spec_helper"

describe "vm::atom", :"full-node" do
  let(:atom_version) { vm_user_gui_command("atom -v").stdout }

  it "installs atom 1.32.2" do
    expect(atom_version).to contain "1.32.2"
  end

  describe "configuration" do
    let(:atom_config) { file("#{vm_user_home}/.atom/config.cson") }

    it "configures atom to have sublime tabs behaviour" do
      expect(atom_config).to contain "usePreviewTabs: true"
    end

    it "configures atom to show invisible characters" do
      expect(atom_config).to contain "showInvisibles: true"
    end
  end

  describe "plugins" do
    let(:installed_plugins) { vm_user_command("apm list -i -b").stdout }

    it 'installs "atom-beautify" plugin v0.33.4' do
      expect(installed_plugins).to contain "atom-beautify@0.33.4"
    end
    it 'installs "minimap" plugin v4.29.9' do
      expect(installed_plugins).to contain "minimap@4.29.9"
    end
    it 'installs "language-chef" plugin v3.5.1' do
      expect(installed_plugins).to contain "language-chef@3.5.1"
    end
    it 'installs "language-ansible" plugin v0.2.2' do
      expect(installed_plugins).to contain "language-ansible@0.2.2"
    end
  end
end
