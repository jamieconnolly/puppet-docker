require "formula"

class Docker < Formula
  homepage "http://docker.io/"
  url "https://github.com/docker/docker.git", :tag => "v1.3.2"

  version "1.3.2-boxen1"

  bottle do
    sha1 "9ebe5d8c93bdfacc83b95ada937503189d5368a2" => :yosemite
    sha1 "7aa8a5484104008254c7815739c3257a00a75a0b" => :mavericks
    sha1 "811f911e31fdf9feff208b075ba6f60cb546a874" => :mountain_lion
  end

  option "without-completions", "Disable bash/zsh completions"

  depends_on "go" => :build

  def upstream_version
    version.to_s.split('-').first
  end

  def install
    ENV["GIT_DIR"] = cached_download/".git"
    ENV["AUTO_GOPATH"] = "1"
    ENV["DOCKER_CLIENTONLY"] = "1"

    system "hack/make.sh", "dynbinary"
    bin.install "bundles/#{upstream_version}/dynbinary/docker-#{upstream_version}" => "docker"

    if build.with? "completions"
      bash_completion.install "contrib/completion/bash/docker"
      zsh_completion.install "contrib/completion/zsh/_docker"
    end
  end

  test do
    system "#{bin}/docker", "--version"
  end
end
