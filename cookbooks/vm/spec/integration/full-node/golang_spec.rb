require "spec_helper"

describe "vm::golang", :"full-node" do

  let(:go_version) { vm_user_command("go version").stdout }
  let(:go_packages) { vm_user_command("go list ...").stdout }

  it "installs go (1.11.2)" do
    expect(go_version).to contain "1.11.2"
  end

  describe "packages" do
    it "installs gocode" do
      expect(go_packages).to contain "github.com/mdempsky/gocode"
    end

    it "installs go-outline" do
      expect(go_packages).to contain "github.com/ramya-rao-a/go-outline"
    end

    it "installs go-symbols" do
      expect(go_packages).to contain "github.com/acroca/go-symbols"
    end

    it "installs gopkgs" do
      expect(go_packages).to contain "github.com/uudashr/gopkgs"
    end

    it "installs guru" do
      expect(go_packages).to contain "golang.org/x/tools/cmd/guru"
    end

    it "installs gorename" do
      expect(go_packages).to contain "golang.org/x/tools/cmd/gorename"
    end

    it "installs goimports" do
      expect(go_packages).to contain "golang.org/x/tools/cmd/goimports"
    end

    it "installs godoc" do
      expect(go_packages).to contain "github.com/zmb3/gogetdoc"
    end

    it "installs gometalinter" do
      expect(go_packages).to contain "github.com/alecthomas/gometalinter"
    end

    it "installs dlv" do
      expect(go_packages).to contain "github.com/derekparker/delve/cmd/dlv"
    end

    it "installs go-langserver" do
      expect(go_packages).to contain "github.com/sourcegraph/go-langserver"
    end
  end
end
