require "spec_helper"

describe "docker::config" do
  let(:facts) { default_test_facts }
  let(:params) { {
    "ensure"     => "present",

    "configdir"  => "/test/boxen/config/docker",
    "datadir"    => "/test/boxen/data/docker",
    "executable" => "/test/boxen/homebrew/bin/docker",
    "logdir"     => "/test/boxen/log/docker",
    "user"       => "docker",

    "ip"         => "127.0.0.1",
    "port"       => "14243",

    "service"    => "dev.docker",
  } }

  it do
    %w(config data log).each do |d|
      should contain_file("/test/boxen/#{d}/docker").with_ensure(:directory)
    end
  end

  context "Darwin" do
    let(:facts) { default_test_facts.merge(:operatingsystem => "Darwin", :osfamily => "Darwin") }

    it do
      should contain_boxen__env_script("docker")
      should contain_file("/test/boxen/config/docker/profile")
      should contain_file("/Library/LaunchDaemons/dev.docker.plist")
    end
  end

  context "Ubuntu" do
    let(:facts) { default_test_facts.merge(:operatingsystem => "Ubuntu", :osfamily => "Debian") }

    it do
      should_not contain_boxen__env_script("docker")
      should_not contain_file("/test/boxen/config/docker/profile")
      should_not contain_file("/Library/LaunchDaemons/dev.docker.plist")
    end
  end
end
