require "spec_helper"

describe "vm::bash", :"full-node" do
  it "sets up the .bashrc.d/ directory for the vm user" do
    expect(file("#{vm_user_home}/.bashrc.d")).to be_directory
    expect(file("#{vm_user_home}/.bashrc.d")).to be_owned_by vm_user
  end

  it "sets up shell alias `be` => `bundle exec` for the vm user" do
    expect(vm_user_command("be").stdout).to contain "bundler: exec needs a command to run"
  end
end
