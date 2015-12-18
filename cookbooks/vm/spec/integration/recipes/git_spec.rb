require 'spec_helper'
require 'chef/sugar/docker'

describe 'vm::git' do

  # simulate an X environment in docker / circleci
  if Chef::Sugar::Docker.docker?(@node)
    meld_version = 'xvfb-run meld --version'
  else
    meld_version = 'meld --version'
  end

  it 'installs git' do
    expect(package('git')).to be_installed
    expect(devbox_user_command('git --version').exit_status).to eq 0
  end

  it 'installs meld for diffing / merging' do
    expect(package('meld')).to be_installed
    expect(devbox_user_command(meld_version).exit_status).to eq 0
  end

  context '~/.gitconfig' do
    it 'configures meld as the difftool' do
      pending('todo')
    end
    it 'configures meld as the mergetool' do
      pending('todo')
    end
  end
end
