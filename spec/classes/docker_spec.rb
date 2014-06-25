require "spec_helper"

describe "docker" do
  let(:facts) { default_test_facts }
  let(:params) { {
    "configdir"  => "%{::boxen::config::configdir}/docker",
    "datadir"    => "%{::boxen::config::datadir}/docker",
    "logdir"     => "%{::boxen::config::logdir}/docker",
  } }

  it do
    should contain_class("docker::config")
    should contain_class("docker::package")
    should contain_class("docker::service")
  end
end
