require "spec_helper"

describe "docker::config" do
  let(:test_params) { {
    :ensure    => "present",
    :configdir => "/test/boxen/config/docker",
    :datadir   => "/test/boxen/data/docker",
    :logdir    => "/test/boxen/log/docker",
    :service   => "dev.docker",
  } }

  let(:facts) { default_test_facts }
  let(:params) { test_params }

  context "ensure => present" do
    it do
      %w(config data log).each do |d|
        should contain_file("/test/boxen/#{d}/docker").with_ensure(:directory)
      end
    end
  end

  context "ensure => absent" do
    let(:params) { test_params.merge(:ensure => "absent") }

    it do
      %w(config data log).each do |d|
        should contain_file("/test/boxen/#{d}/docker").with_ensure("absent")
      end
    end
  end

  describe "Darwin" do
    context "ensure => present" do
      it do
        should contain_boxen__env_script("docker").with_ensure("present")
        should contain_file("/test/boxen/config/docker/profile").with_ensure("present")
        should contain_file("/Library/LaunchDaemons/dev.docker.plist").with_ensure("present")
      end
    end

    context "ensure => absent" do
      let(:params) { test_params.merge(:ensure => "absent") }

      it do
        should contain_boxen__env_script("docker").with_ensure("absent")
        should contain_file("/test/boxen/config/docker/profile").with_ensure("absent")
        should contain_file("/Library/LaunchDaemons/dev.docker.plist").with_ensure("absent")
      end
    end
  end

  describe "Ubuntu" do
    let(:facts) { default_test_facts.merge(:operatingsystem => "Ubuntu") }

    it do
      should_not contain_boxen__env_script("docker")
      should_not contain_file("/test/boxen/config/docker/profile")
      should_not contain_file("/Library/LaunchDaemons/dev.docker.plist")
    end
  end
end
