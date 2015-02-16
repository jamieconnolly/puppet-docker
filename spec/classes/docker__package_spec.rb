require "spec_helper"

describe "docker::package" do
  let(:test_params) { {
    :ensure  => "present",
    :package => "docker",
    :version => "1.0.0",
  } }

  let(:facts) { default_test_facts }
  let(:params) { test_params }

  context "ensure => present" do
    it do
      should contain_package("docker").with_ensure("1.0.0")
    end
  end

  context "ensure => absent" do
    let(:params) { test_params.merge(:ensure => "absent") }

    it do
      should contain_package("docker").with_ensure("absent")
    end
  end

  describe "osfamily => Darwin" do
    context "ensure => present" do
      it do
        should contain_package("boot2docker").with_ensure("1.0.0")
      end
    end

    context "ensure => absent" do
      let(:params) { test_params.merge(:ensure => "absent") }

      it do
        should contain_package("boot2docker").with_ensure("absent")
      end
    end
  end

  describe "osfamily => Debian" do
    let(:facts) { default_test_facts.merge(:osfamily => "Debian") }

    it do
      should_not contain_package("boot2docker")
    end
  end
end
