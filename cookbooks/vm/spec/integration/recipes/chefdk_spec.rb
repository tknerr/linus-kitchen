require 'spec_helper'

describe 'vm::chefdk' do

  it 'runs these tests under the vagrant user' do
    expect(devbox_user_command('whoami').stdout.strip).to eq 'vagrant'
    expect(devbox_user_command('echo $HOME').stdout.strip).to eq '/home/vagrant'
    expect(devbox_user_command('echo $SHELL').stdout.strip).to eq '/bin/bash'
    expect(devbox_user_command('echo $VAGRANT_DEFAULT_PROVIDER').stdout.strip).to eq 'docker'
  end

  it 'makes sure that the shell is initialized for chef' do
    chefdk_gem_home = '/home/vagrant/.chefdk/gem/ruby/2.1.0'
    chefdk_gem_root = '/opt/chefdk/embedded/lib/ruby/gems/2.1.0'
    expect(devbox_user_command('echo $GEM_HOME').stdout.strip).to eq chefdk_gem_home
    expect(devbox_user_command('echo $GEM_ROOT').stdout.strip).to eq chefdk_gem_root
    expect(devbox_user_command('echo $GEM_PATH').stdout.strip).to eq "#{chefdk_gem_home}:#{chefdk_gem_root}"
    expect(devbox_user_command('echo $PATH').stdout).to start_with "/opt/chefdk/bin:#{chefdk_gem_home}/bin:/opt/chefdk/embedded/bin:"
  end

  it 'configures bundler to use 16 parallel jobs' do
    expect(devbox_user_command('bundle config --global jobs').stdout).to contain '16'
  end
  it 'configures bundler to retry 3 times' do
    expect(devbox_user_command('bundle config --global retry').stdout).to contain '3'
  end
  it 'configures bundler to install gems to ~/.chefdk' do
    expect(devbox_user_command('bundle config --global path').stdout).to contain '/home/vagrant/.chefdk/gem/ruby/2.1.0'
  end
end
