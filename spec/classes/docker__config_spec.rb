require "spec_helper"

describe "docker::config" do
  let(:test_params) { {
    :ensure    => "present",
    :configdir => "/test/boxen/config/docker",
    :datadir   => "/test/boxen/data/docker",
  } }

  let(:facts) { default_test_facts }
  let(:params) { test_params }

  context "ensure => present" do
    it do
      %w(config data).each do |d|
        should contain_file("/test/boxen/#{d}/docker").with_ensure(:directory)
      end
    end
  end

  context "ensure => absent" do
    let(:params) { test_params.merge(:ensure => "absent") }

    it do
      %w(config data).each do |d|
        should contain_file("/test/boxen/#{d}/docker").with_ensure("absent")
      end
    end
  end

  describe "osfamily => Darwin" do
    context "ensure => present" do
      it do
        should contain_boxen__env_script("docker").with_ensure("present")
        should contain_file("/test/boxen/config/docker/profile").with_ensure("present")
      end
    end

    context "ensure => absent" do
      let(:params) { test_params.merge(:ensure => "absent") }

      it do
        should contain_boxen__env_script("docker").with_ensure("absent")
        should contain_file("/test/boxen/config/docker/profile").with_ensure("absent")
      end
    end
  end

  describe "osfamily => Debian" do
    let(:facts) { default_test_facts.merge(:osfamily => "Debian") }

    it do
      should_not contain_boxen__env_script("docker")
      should_not contain_file("/test/boxen/config/docker/profile")
    end
  end
end
