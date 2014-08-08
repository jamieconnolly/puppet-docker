require "spec_helper"

describe "docker::service" do
  let(:test_params) { {
    :ensure  => "present",
    :service => "dev.docker",
    :enable  => true,
  } }

  let(:facts) { default_test_facts }
  let(:params) { test_params }

  context "ensure => present" do
    it do
      # should contain_service("dev.docker").with({
        # :ensure => :running,
        # :enable => true,
        # :alias  => "docker"
      # })
    end
  end

  context "ensure => absent" do
    let(:params) { test_params.merge(:ensure => "absent") }

    it do
      # should contain_service("dev.docker").with({
        # :ensure => :stopped,
        # :enable => true,
        # :alias  => "docker"
      # })
    end
  end
end
