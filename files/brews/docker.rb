require "formula"

class Docker < Formula
  homepage "http://docker.io/"
  url "https://github.com/docker/docker.git", :tag => "v1.3.0"

  version "1.3.0-boxen1"

  bottle do
    sha1 "7563b28df830baa880731b9448e88b99dcb68420" => :mavericks
    sha1 "4ecba686ae851cb091bec58aebab1c092a5edfbf" => :mountain_lion
    sha1 "697f44626b6dd3152fb23d6da8272cb2359a6845" => :lion
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
