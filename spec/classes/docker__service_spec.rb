require "spec_helper"

describe "docker::service" do
  let(:test_params) { {
    :ensure    => "present",
    :configdir => "/test/boxen/config/docker",
    :datadir   => "/test/boxen/data/docker",
    :user      => "testuser",
    :service   => "dev.docker",
    :enable    => true,
  } }

  let(:facts) { default_test_facts }
  let(:params) { test_params }

  context "ensure => present" do
    it do
      should contain_service("dev.docker").with({
        :ensure => :running,
        :enable => true,
        :alias  => "docker"
      })
    end
  end

  context "ensure => absent" do
    let(:params) { test_params.merge(:ensure => "absent") }

    it do
      should contain_service("dev.docker").with({
        :ensure => :stopped,
        :enable => true,
        :alias  => "docker"
      })
    end
  end

  describe "Darwin" do
    context "ensure => present" do
      it do
        should contain_exec("init-boot2docker-vm").with({
          :command     => "boot2docker init",
          :environment => [
            "BOOT2DOCKER_DIR=/test/boxen/data/docker",
            "BOOT2DOCKER_PROFILE=/test/boxen/config/docker/profile"
          ],
          :require     => "Package[boxen/brews/boot2docker]",
          :user        => "testuser",
          :unless      => "boot2docker status",
          :before      => "Service[docker]",
          :notify      => "Service[docker]",
        })
        should_not contain_exec("delete-boot2docker-vm")
      end
    end

    context "ensure => absent" do
      let(:params) { test_params.merge(:ensure => "absent") }

      it do
        should_not contain_exec("init-boot2docker-vm")
        should contain_exec("delete-boot2docker-vm").with({
          :command     => "boot2docker delete",
          :environment => [
            "BOOT2DOCKER_DIR=/test/boxen/data/docker",
            "BOOT2DOCKER_PROFILE=/test/boxen/config/docker/profile"
          ],
          :onlyif      => "boot2docker status",
          :require     => "Package[boxen/brews/boot2docker]",
          :user        => "testuser",
          :before      => "Service[docker]",
          :notify      => "Service[docker]",
        })
      end
    end
  end

  describe "Ubuntu" do
    let(:facts) { default_test_facts.merge(:operatingsystem => "Ubuntu") }

    it do
      should_not contain_exec("boot2docker")
    end
  end
end
