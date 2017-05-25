require 'spec_helper'

describe 'vm::ansible' do

  let(:ansible_version) { vm_user_gui_command('ansible --version').stdout }
  let(:pytest_version) { vm_user_gui_command('pytest --version').stdout }
  let(:molecule_version) { vm_user_gui_command('molecule --version').stdout }

  it 'installs ansible 2.3.0.0' do
    expect(ansible_version).to contain '2.3.0.0'
  end
  it 'installs testinfra 1.6.2' do
    expect(pytest_version).to contain 'testinfra-1.6.2'
  end
  it 'installs pytest-spec 1.1.0' do
    expect(pytest_version).to contain 'pytest-spec-1.1.0'
  end
  it 'installs molecule 2.0.0.0rc4' do
    expect(molecule_version).to contain '2.0.0.0rc4'
  end
end
