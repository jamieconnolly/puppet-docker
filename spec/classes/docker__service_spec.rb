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
end
