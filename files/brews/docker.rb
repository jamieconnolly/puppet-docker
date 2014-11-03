require "formula"

class Docker < Formula
  homepage "http://docker.io/"
  url "https://github.com/docker/docker.git", :tag => "v1.3.1"

  version "1.3.1-boxen1"

  bottle do
    sha1 "bb86bca796dda4c816951ce063f6c5f7eb506777" => :yosemite
    sha1 "3ba79c3636d5d68b429cd3324d7c4af9ad48574f" => :mavericks
    sha1 "ae630709885fbd929bd41fae9a1599972a7fafd2" => :mountain_lion
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
