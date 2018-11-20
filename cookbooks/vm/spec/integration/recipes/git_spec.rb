require 'spec_helper'

describe 'vm::git' do

  let(:meld_version) { vm_user_gui_command('meld --version') }
  let(:git_version) { vm_user_command('git --version') }
  let(:git_config) { vm_user_command('git config --global --list').stdout }

  it 'installs git' do
    expect(package('git')).to be_installed
    expect(git_version.exit_status).to eq 0
  end

  it 'installs meld (for diffing and merging)' do
    expect(package('meld')).to be_installed
    expect(meld_version.exit_status).to eq 0
  end

  it 'installs git ps1 config' do
    expect(file("#{vm_user_home}/.bashrc.d/setup-git-ps1-prompt")).to exist
  end

  context '~/.gitconfig' do
    it 'configures meld as the difftool' do
      expect(git_config).to contain 'diff.tool=meld'
    end
    it 'configures meld as the mergetool' do
      expect(git_config).to contain 'merge.tool=meld'
    end
    it 'disables ssl verification' do
      expect(git_config).to contain 'http.sslverify=false'
    end
    context 'aliases' do
      aliases = {
        co: 'checkout',
        ci: 'commit',
        br: 'branch',
        st: 'status',
        unstage: 'reset HEAD --',
        slog: 'log --pretty=oneline --abbrev-commit',
        graph: 'log --all --oneline --graph --decorate'
      }
      aliases.each do |shortcut, command|
        it "'#{shortcut}' for '#{command}'" do
          expect(git_config).to contain "alias.#{shortcut}=#{command}"
        end
      end
    end
  end
end
