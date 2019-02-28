require "spec_helper"

describe "vm::virtualbox", :"full-node" do
  let(:virtualbox_version) { vm_user_command("vboxmanage --version").stdout.strip }

  it "installs VirtualBox 6.0.4" do
    expect(virtualbox_version).to match "6.0.4"
  end
end
