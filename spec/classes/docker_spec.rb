require "spec_helper"

describe "docker" do
  let(:facts) { default_test_facts }
  let(:params) { {
    :configdir => "/test/boxen/config/docker",
    :datadir   => "/test/boxen/data/docker",
    :logdir    => "/test/boxen/log/docker",
  } }

  it do
    should contain_class("docker::config")
    should contain_class("docker::package")
    should contain_class("docker::service")
  end
end
