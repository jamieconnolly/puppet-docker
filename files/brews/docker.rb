require "formula"

class Docker < Formula
  homepage "http://docker.io/"
  url "https://github.com/dotcloud/docker.git", :tag => "v1.1.2"

  version "1.1.2-boxen1"

  bottle do
    sha1 "caaca765d2caf1c59904cbddfa8e62c89f32767d" => :mavericks
    sha1 "76443abf1eaaf9b3faea23157d17463b712b7b3f" => :mountain_lion
    sha1 "1b5e3c57a460be422a7fd36cb0105fe06b9d109b" => :lion
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
