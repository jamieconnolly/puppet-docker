require "spec_helper"

describe "docker::package" do
  let(:test_params) { {
    :ensure  => "present",
    :package => "boxen/brews/docker",
    :version => "1.1.2-boxen1",
  } }

  let(:facts) { default_test_facts }
  let(:params) { test_params }

  context "ensure => present" do
    it do
      should contain_package("boxen/brews/docker").with_ensure("1.1.2-boxen1")
    end
  end

  context "ensure => absent" do
    let(:params) { test_params.merge(:ensure => "absent") }

    it do
      should contain_package("boxen/brews/docker").with_ensure("absent")
    end
  end

  describe "Darwin" do
    context "ensure => present" do
      it do
        should contain_homebrew__formula("boot2docker").with_before('Package[boxen/brews/docker]')
        should contain_homebrew__formula("docker").with_before('Package[boxen/brews/docker]')
        should contain_package("boxen/brews/boot2docker").with_ensure("1.1.2-boxen1")
      end
    end

    context "ensure => absent" do
      let(:params) { test_params.merge(:ensure => "absent") }

      it do
        should contain_package("boxen/brews/boot2docker").with_ensure("absent")
      end
    end
  end

  describe "Ubuntu" do
    let(:facts) { default_test_facts.merge(:operatingsystem => "Ubuntu") }

    it do
      should_not contain_homebrew__formula("boot2docker")
      should_not contain_homebrew__formula("docker")
      should_not contain_package("boxen/brews/boot2docker")
    end
  end
end
