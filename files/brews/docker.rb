require "formula"

class Docker < Formula
  homepage "http://docker.io/"
  url "https://github.com/docker/docker.git", :tag => "v1.4.1"

  version "1.4.1-boxen1"

  bottle do
    sha1 "71a4d59ee4d12d7cff6e1125b154596e9de1d271" => :yosemite
    sha1 "aab3097942193361d2a1c0958462103425891255" => :mavericks
    sha1 "71cf01001d2cfed720a1e54fddcc47108ec087f7" => :mountain_lion
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
