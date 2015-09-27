require 'spec_helper'

describe 'vm::bash' do

  it 'sets up the .bash.d/ directory for the devbox user' do
    expect(file('/home/vagrant/.bash.d')).to be_directory
    expect(file('/home/vagrant/.bash.d')).to be_owned_by 'vagrant'
  end

  it 'sets up shell alias `be` => `bundle exec` for the devbox user' do
    expect(command('sudo -u vagrant bash -i -c "be"').stdout).to contain 'bundler: exec needs a command to run'
  end
end
