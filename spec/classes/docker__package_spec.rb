require "spec_helper"

describe "docker::package" do
  let(:facts) { default_test_facts }
  let(:params) { {
    "ensure"  => "present",

    "package" => "docker",
    "version" => "installed"
  } }

  context "Darwin" do
    let(:facts) { default_test_facts.merge(:operatingsystem => "Darwin", :osfamily => "Darwin") }

    it do
      should contain_homebrew__formula("boot2docker")
      should contain_package("docker").with_ensure("installed")
    end
  end

  context "Ubuntu" do
    let(:facts) { default_test_facts.merge(:operatingsystem => "Ubuntu", :osfamily => "Debian") }

    it do
      should_not contain_homebrew__formula("boot2docker")
      should contain_package("docker").with_ensure("installed")
    end
  end
end
