require 'spec_helper'

describe 'docker::machine' do
  let(:test_params) { {
    :ensure  => 'present',
    :package => 'docker-machine',
    :version => '0.4.1',
  } }

  let(:facts) { default_test_facts }
  let(:params) { test_params }

  context 'ensure => present' do
    it do
      should contain_package('docker-machine').with_ensure('0.4.1')
    end
  end

  context 'ensure => absent' do
    let(:params) { test_params.merge(:ensure => 'absent') }

    it do
      should contain_package('docker-machine').with_ensure(:absent)
    end
  end
end
