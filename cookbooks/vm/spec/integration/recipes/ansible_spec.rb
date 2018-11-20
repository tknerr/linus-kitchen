require 'spec_helper'

describe 'vm::ansible' do

  let(:ansible_version) { vm_user_gui_command('ansible --version').stdout }
  let(:ansible_lint_version) { vm_user_gui_command('ansible-lint --version').stdout }
  let(:pytest_version) { vm_user_gui_command('pytest --version').stdout }
  let(:molecule_version) { vm_user_gui_command('molecule --version').stdout }

  it 'installs ansible 2.3.0.0' do
    expect(ansible_version).to contain '2.3.0.0'
  end
  it 'installs ansible-lint 3.4.23' do
    expect(ansible_lint_version).to contain '3.4.23'
  end
  it 'installs testinfra 1.16.0' do
    expect(pytest_version).to contain 'testinfra-1.16.0'
  end
  it 'installs pytest-spec 1.1.0' do
    expect(pytest_version).to contain 'pytest-spec-1.1.0'
  end
  it 'installs molecule 2.19.0' do
    expect(molecule_version).to contain '2.19.0'
  end
end
