require 'spec_helper'
require 'chef/sugar/docker'

describe 'vm::git' do

  # simulate an X environment in docker / circleci
  if Chef::Sugar::Docker.docker?(@node)
    meld_version_cmd = 'xvfb-run meld --version'
  else
    meld_version_cmd = 'meld --version'
  end
  let(:git_version) { devbox_user_command('git --version') }
  let(:meld_version) { devbox_user_command(meld_version_cmd) }
  let(:git_config) { devbox_user_command('git config --global --list').stdout }

  it 'installs git' do
    expect(package('git')).to be_installed
    expect(git_version.exit_status).to eq 0
  end

  it 'installs meld for diffing / merging' do
    expect(package('meld')).to be_installed
    expect(meld_version.exit_status).to eq 0
  end

  context '~/.gitconfig' do
    it 'configures meld as the difftool' do
      expect(git_config).to contain 'diff.tool=meld'
    end
    it 'configures meld as the mergetool' do
      expect(git_config).to contain 'merge.tool=meld'
    end
  end
end
