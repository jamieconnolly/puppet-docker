require "formula"

class Boot2docker < Formula
  homepage "https://github.com/boot2docker/boot2docker-cli"
  url "https://github.com/boot2docker/boot2docker-cli.git", :tag => "v1.3.2"

  version "1.3.2-boxen1"

  bottle do
    sha1 "a549d80b04ba8702e96216e35edfc135850be122" => :yosemite
    sha1 "0aa43fdb1a2b91a1b72e456e2450b2e6e8f16d10" => :mavericks
    sha1 "45d8c0d08597f4dab63fad2379a225a5d41e3288" => :mountain_lion
  end

  depends_on "boxen/brews/docker" => :recommended
  depends_on "go" => :build

  def install
    (buildpath + "src/github.com/boot2docker/boot2docker-cli").install Dir[buildpath/"*"]

    cd "src/github.com/boot2docker/boot2docker-cli" do
      ENV["GOPATH"] = buildpath
      system "go", "get", "-d"

      ENV["GIT_DIR"] = cached_download/".git"
      system "make", "goinstall"
    end

    bin.install "bin/boot2docker-cli" => "boot2docker"
  end

  test do
    system "#{bin}/boot2docker", "version"
  end
end
