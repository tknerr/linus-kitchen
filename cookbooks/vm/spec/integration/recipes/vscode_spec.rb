require 'spec_helper'

describe 'vm::vscode' do
  let(:vscode_version) { vm_user_gui_command('code -v').stdout }
  # let(:vscode_config) { file("#{vm_user_home}/.vscode/config.cson") }
  let(:installed_plugins) { vm_user_command('code --list-extensions --show-versions').stdout }

  it 'installs vscode 1.31.1' do
    expect(vscode_version).to contain '1.31.1'
  end

  describe 'plugins' do
    it 'installs "bbenoist.vagrant" plugin v0.5.0' do
      expect(installed_plugins).to contain 'bbenoist.vagrant@0.5.0'
    end
    it 'installs "dhoeric.ansible-vault" plugin v0.1.3' do
      expect(installed_plugins).to contain 'dhoeric.ansible-vault@0.1.3'
    end
    it 'installs "donjayamanne.githistory" plugin v0.4.6' do
      expect(installed_plugins).to contain 'donjayamanne.githistory@0.4.6'
    end
    it 'installs "eamodio.gitlens" plugin v9.5.1' do
      expect(installed_plugins).to contain 'eamodio.gitlens@9.5.1'
    end
    it 'installs "felipecaputo.git-project-manager" plugin v1.7.1' do
      expect(installed_plugins).to contain 'felipecaputo.git-project-manager@1.7.1'
    end
    it 'installs "mde.select-highlight-minimap" plugin v0.0.8' do
      expect(installed_plugins).to contain 'mde.select-highlight-minimap@0.0.8'
    end
    it 'installs "ms-python.python" plugin v2019.1.0' do
      expect(installed_plugins).to contain 'ms-python.python@2019.1.0'
    end
    it 'installs "ms-vscode.sublime-keybindings" plugin v4.0.0' do
      expect(installed_plugins).to contain 'ms-vscode.sublime-keybindings@4.0.0'
    end
    it 'installs "Pendrica.chef" plugin v0.7.1' do
      expect(installed_plugins).to contain 'Pendrica.chef@0.7.1'
    end
    it 'installs "PeterJausovec.vscode-docker" plugin 0.5.2' do
      expect(installed_plugins).to contain 'peterjausovec.vscode-docker@0.5.2'
    end
    it 'installs "vscoss.vscode-ansible" plugin v0.5.2' do
      expect(installed_plugins).to contain 'vscoss.vscode-ansible@0.5.2'
    end
    it 'installs "yzhang.markdown-all-in-one" plugin v2.0.1' do
      expect(installed_plugins).to contain 'yzhang.markdown-all-in-one@2.0.1'
    end
    it 'installs "zikalino.azure-rest-for-ansible" plugin v0.0.18' do
      expect(installed_plugins).to contain 'zikalino.azure-rest-for-ansible@0.0.18'
    end
  end

#   it 'configures vscode to have sublime tabs behaviour' do
#     expect(vscode_config).to contain 'usePreviewTabs: true'
#   end
#   it 'configures vscode to show invisible characters' do
#     expect(vscode_config).to contain 'showInvisibles: true'
#   end
end
