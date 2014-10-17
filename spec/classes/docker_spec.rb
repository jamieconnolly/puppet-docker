require "spec_helper"

describe "docker" do
  let(:facts) { default_test_facts }
  let(:params) { {
    :configdir => "/test/boxen/config/docker",
    :datadir   => "/test/boxen/data/docker",
  } }

  it do
    should include_class("virtualbox")

    should contain_class("docker::config")
    should contain_class("docker::package")
  end
end
