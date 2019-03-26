require "spec_helper"

describe "vm::base", :"full-node" do
  it "installs vim" do
    expect(package("vim")).to be_installed
    expect(command("vim --version").exit_status).to eq 0
  end

  it "installs development headers for installing nokogiri etc." do
    %w(libxml2-dev libxslt1-dev zlib1g-dev liblzma-dev).each do |pkg|
      expect(package(pkg)).to be_installed
    end
  end

  it "places a README on the Desktop" do
    expect(file("#{vm_user_home}/Desktop/README.md")).to exist
  end
end
