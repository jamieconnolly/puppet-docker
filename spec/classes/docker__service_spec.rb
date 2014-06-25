require "spec_helper"

describe "docker::service" do
  let(:facts) { default_test_facts }
  let(:params) { {
    "ensure"  => "present",

    "service" => "dev.docker",
    "enable"  => true
  } }

  it do
    should contain_service("dev.docker").with({
      :ensure => :running,
      :enable => true,
      :alias  => "docker"
    })
  end

  context "Darwin" do
    let(:facts) { default_test_facts.merge(:operatingsystem => "Darwin", :osfamily => "Darwin") }

    it do
      should contain_exec("init-boot2docker-vm")
      should contain_service("dev.docker").with({
        :ensure => :running,
        :enable => true,
        :alias  => "docker"
      })
    end
  end

  context "Ubuntu" do
    let(:facts) { default_test_facts.merge(:operatingsystem => "Ubuntu", :osfamily => "Debian") }

    it do
      should_not contain_exec("init-boot2docker-vm")
      should contain_service("dev.docker").with({
        :ensure => :running,
        :enable => true,
        :alias  => "docker"
      })
    end
  end
end
