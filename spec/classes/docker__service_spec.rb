require "spec_helper"

describe "docker::service" do
  let(:test_params) { {
    :ensure    => "present",
    :configdir => "/test/boxen/config/docker",
    :datadir   => "/test/boxen/data/docker",
    :enable    => true,
    :service   => "dev.docker",
    :user      => "testuser",
  } }

  let(:facts) { default_test_facts }
  let(:params) { test_params }

  context "ensure => present" do
    it do
      should contain_service("dev.docker").with({
        :ensure => :running,
        :enable => true,
      })
    end
  end

  context "ensure => absent" do
    let(:params) { test_params.merge(:ensure => "absent") }

    it do
      should contain_service("dev.docker").with_ensure("stopped")
    end
  end

  context "enable => false" do
    let(:params) { test_params.merge(:enable => false) }

    it do
      should contain_service("dev.docker").with_enable(false)
    end
  end

  describe "osfamily => Darwin" do
    context "ensure => present" do
      it do
        should contain_exec("boot2docker-vm").with({
          :command     => "boot2docker init",
          :environment => [
            "BOOT2DOCKER_DIR=/test/boxen/data/docker",
            "BOOT2DOCKER_PROFILE=/test/boxen/config/docker/profile"
          ],
          :user        => "testuser",
          :unless      => "boot2docker status | grep \"machine not exist\"",
        })
      end
    end

    context "ensure => absent" do
      let(:params) { test_params.merge(:ensure => "absent") }

      it do
        should contain_exec("boot2docker-vm").with({
          :command     => "boot2docker delete",
          :environment => [
            "BOOT2DOCKER_DIR=/test/boxen/data/docker",
            "BOOT2DOCKER_PROFILE=/test/boxen/config/docker/profile"
          ],
          :user        => "testuser",
          :unless      => "boot2docker status",
        })
      end
    end
  end

  describe "osfamily => Debian" do
    let(:facts) { default_test_facts.merge(:osfamily => "Debian") }

    it do
      should_not contain_exec("boot2docker-vm")
    end
  end
end
