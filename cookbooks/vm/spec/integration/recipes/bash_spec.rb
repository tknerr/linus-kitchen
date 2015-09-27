require 'spec_helper'

describe 'vm::bash' do

  it 'sets up the .bash.d/ directory for the devbox user' do
    expect(file("/home/#{devbox_user}/.bash.d")).to be_directory
    expect(file("/home/#{devbox_user}/.bash.d")).to be_owned_by devbox_user
  end

  it 'sets up shell alias `be` for `bundle exec`' do
    expect(command("sudo -u #{devbox_user} bash -i -c 'be'").stdout).to contain 'bundler: exec needs a command to run'
  end
end
