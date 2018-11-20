require 'spec_helper'

describe 'vm::chefdk' do

  it 'runs these tests under the vm user' do
    expect(vm_user_command('whoami').stdout.strip).to eq vm_user
    expect(vm_user_command('echo $HOME').stdout.strip).to eq vm_user_home
    expect(vm_user_command('echo $SHELL').stdout.strip).to eq '/bin/bash'
  end

  it 'makes sure that the shell is initialized for chef' do
    chefdk_gem_home = "#{vm_user_home}/.chefdk/gem/ruby/2.5.0"
    chefdk_gem_root = '/opt/chefdk/embedded/lib/ruby/gems/2.5.0'
    expect(vm_user_command('echo $GEM_HOME').stdout.strip).to eq chefdk_gem_home
    expect(vm_user_command('echo $GEM_ROOT').stdout.strip).to eq chefdk_gem_root
    expect(vm_user_command('echo $GEM_PATH').stdout.strip).to eq "#{chefdk_gem_home}:#{chefdk_gem_root}"
    expect(vm_user_command('echo $PATH').stdout).to start_with "/opt/chefdk/bin:#{chefdk_gem_home}/bin:/opt/chefdk/embedded/bin:"
  end

  it 'configures bundler to use 16 parallel jobs' do
    expect(vm_user_command('bundle config --global jobs').stdout).to contain '16'
  end
  it 'configures bundler to retry 3 times' do
    expect(vm_user_command('bundle config --global retry').stdout).to contain '3'
  end
  it 'configures bundler to install gems to ~/.chefdk' do
    expect(vm_user_command('bundle config --global path').stdout).to contain "#{vm_user_home}/.chefdk/gem/ruby/2.3.0"
  end

  it 'does not leave any root owned files under the user\'s home directory' do
    expect(vm_user_command("find #{vm_user_home} -type d -maxdepth 1 -user root").stdout).to be_empty
  end
end
