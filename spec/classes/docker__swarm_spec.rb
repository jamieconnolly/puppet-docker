require 'spec_helper'

describe 'docker::swarm' do
  let(:test_params) { {
    :ensure  => 'present',
    :package => 'docker-swarm',
    :version => '0.4.0',
  } }

  let(:facts) { default_test_facts }
  let(:params) { test_params }

  context 'ensure => present' do
    it do
      should contain_package('docker-swarm').with_ensure('0.4.0')
    end
  end

  context 'ensure => absent' do
    let(:params) { test_params.merge(:ensure => 'absent') }

    it do
      should contain_package('docker-swarm').with_ensure(:absent)
    end
  end
end
