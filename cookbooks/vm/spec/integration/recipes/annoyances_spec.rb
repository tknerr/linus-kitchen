require 'spec_helper'

describe 'vm::annoyances' do

  it 'updates bundler to version to 1.10.6' do
    expect(devbox_user_command('bundle -v').stdout).to match 'Bundler version 1.10.6'
  end
end
