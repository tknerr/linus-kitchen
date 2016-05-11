require 'spec_helper'

describe 'vm::vagrant' do

  let(:vagrant_version) { devbox_user_command('vagrant -v').stdout.strip }
  let(:installed_plugins) { devbox_user_command('vagrant plugin list').stdout }

  it 'installs vagrant 1.8.1' do
    expect(vagrant_version).to match 'Vagrant 1.8.1'
  end

  it 'configures "docker" as the $VAGRANT_DEFAULT_PROVIDER' do
    expect(devbox_user_command('echo $VAGRANT_DEFAULT_PROVIDER').stdout.strip).to eq 'docker'
  end

  it 'installs "vagrant-cachier" plugin 1.2.1' do
    expect(installed_plugins).to include 'vagrant-cachier (1.2.1)'
  end
  it 'installs "vagrant-berkshelf" plugin 4.1.0' do
    expect(installed_plugins).to include 'vagrant-berkshelf (4.1.0)'
  end
  it 'installs "vagrant-omnibus" plugin 1.4.1' do
    expect(installed_plugins).to include 'vagrant-omnibus (1.4.1)'
  end
  it 'installs "vagrant-toplevel-cookbooks" plugin 0.2.4' do
    expect(installed_plugins).to include 'vagrant-toplevel-cookbooks (0.2.4)'
  end
  it 'installs "vagrant-lxc" plugin 1.1.0' do
    expect(installed_plugins).to include 'vagrant-lxc (1.1.0)'
  end
end
