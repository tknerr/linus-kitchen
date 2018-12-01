require "spec_helper"

describe "vm::vscode", :"golang-dev" do
  let(:code_version) { vm_user_gui_command("code -v").stdout }
  let(:code_config) { file("#{vm_user_home}/.config/Code/User/settings.json") }
  let(:installed_plugins) { vm_user_command("code --list-extensions").stdout }

  it "installs vscode 1.29.1" do
    expect(code_version).to contain "1.29.1"
  end

  describe "plugins" do
    it 'installs "vscode-icons" plugin' do
      expect(installed_plugins).to contain "robertohuertasm.vscode-icons"
    end
    it 'installs "gitlens" plugin' do
      expect(installed_plugins).to contain "eamodio.gitlens"
    end
    it 'installs "Go" plugin' do
      expect(installed_plugins).to contain "ms-vscode.Go"
    end
    it 'installs "Go Test Explorer" plugin' do
      expect(installed_plugins).to contain "premparihar.gotestexplorer"
    end
  end

  it "configures code to safe files automatically" do
    expect(code_config).to contain '"files.autoSave": "afterDelay"'
  end
  it "configures code to format files automatically" do
    expect(code_config).to contain '"editor.formatOnSave": true'
  end
end
