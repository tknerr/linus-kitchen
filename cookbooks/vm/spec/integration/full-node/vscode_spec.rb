require "spec_helper"

describe "vm::vscode", :"full-node" do
  let(:code_version) { vm_user_gui_command("code -v").stdout }
  let(:code_config) { file("#{vm_user_home}/.config/Code/User/settings.json") }
  let(:installed_plugins) { vm_user_command("code --list-extensions").stdout }

  it "installs vscode 1.31.1" do
    expect(code_version).to contain "1.31.1"
  end

  describe "plugins" do
    it 'installs "vscode-icons" plugin' do
      expect(installed_plugins).to contain "vscode-icons-team.vscode-icons"
    end
    it 'installs "gitlens" plugin' do
      expect(installed_plugins).to contain "eamodio.gitlens"
    end
    it 'installs "Ruby" plugin' do
      expect(installed_plugins).to contain "rebornix.ruby"
    end
    it 'installs "Solargraph" plugin' do
      expect(installed_plugins).to contain "castwide.solargraph"
    end
    it 'installs "Rufo" plugin' do
      expect(installed_plugins).to contain "mbessey.vscode-rufo"
    end
    it 'installs "Chef" plugin' do
      expect(installed_plugins).to contain "Pendrica.chef"
    end
    it 'installs "Vagrant" plugin' do
      expect(installed_plugins).to contain "bbenoist.vagrant"
    end
    it 'installs "Docker" plugin' do
      expect(installed_plugins).to contain "PeterJausovec.vscode-docker"
    end
  end

  it "configures code to safe files automatically" do
    expect(code_config).to contain '"files.autoSave": "afterDelay"'
  end
  it "configures code to format files automatically" do
    expect(code_config).to contain '"editor.formatOnSave": true'
  end
end
