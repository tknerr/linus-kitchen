require 'spec_helper'

describe 'vm::git' do

  it 'installs git' do
    expect(package('git')).to be_installed
    expect(command('git --version').exit_status).to eq 0
  end

  it 'installs meld as the diff / merge tool' do
    expect(package('meld')).to be_installed
    expect(command('meld --version').exit_status).to eq 0
  end

  context '~/.gitconfig' do
    it 'configures meld as the difftool' do
      expect(command('meld --version').exit_status).to eq 0
    end
    it 'configures meld as the mergetool' do
      expect(command('meld --version').exit_status).to eq 0
    end
  end
end
