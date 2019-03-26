require "spec_helper"

describe "vm::packer", :"full-node" do
  let(:packer_version) { vm_user_command("packer -v").stdout.strip }

  it "installs packer 1.3.4" do
    expect(packer_version).to eq "1.3.4"
  end
end
