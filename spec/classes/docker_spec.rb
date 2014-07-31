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

  context "Darwin" do
    let(:facts) { default_test_facts.merge(:operatingsystem => "Darwin", :osfamily => "Darwin") }

    it do
      should contain_class("virtualbox")
    end
  end

  context "Ubuntu" do
    let(:facts) { default_test_facts.merge(:operatingsystem => "Ubuntu", :osfamily => "Debian") }

    it do
      should_not contain_class("virtualbox")
    end
  end
end
