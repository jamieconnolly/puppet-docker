require "formula"

class Boot2docker < Formula
  homepage "https://github.com/boot2docker/boot2docker-cli"
  url "https://github.com/boot2docker/boot2docker-cli.git", :tag => "v1.4.1"

  version "1.4.1-boxen1"

  bottle do
    sha1 "9e23c1d530e7ef94fbac0c02eb02fecb943c8f7b" => :yosemite
    sha1 "72dc462b5bf76c4c69e35aef14e6d4ffa7bbcb6e" => :mavericks
    sha1 "82da9c5a4f56d4fe5e4fd08d1a2098cb40842bc5" => :mountain_lion
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
