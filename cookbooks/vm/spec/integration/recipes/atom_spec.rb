require 'spec_helper'

describe 'vm::atom' do

  it 'installs atom 1.1.0' do
    expect(devbox_user_command('atom -v').stdout.strip).to eq '1.1.0'
  end

  it 'installs some useful atom plugins' do
    installed_plugins = devbox_user_command('apm list -i').stdout
    expect(installed_plugins).to match 'atom-beautify'
    expect(installed_plugins).to match 'minimap'
    expect(installed_plugins).to match 'line-ending-converter'
    expect(installed_plugins).to match 'language-chef'
    expect(installed_plugins).to match 'language-batchfile'
  end
end
