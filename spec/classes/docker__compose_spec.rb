require 'spec_helper'

describe 'docker::compose' do
  let(:test_params) { {
    :ensure  => 'present',
    :package => 'docker-compose',
    :version => '1.4.2',
  } }

  let(:facts) { default_test_facts }
  let(:params) { test_params }

  context 'ensure => present' do
    it do
      should contain_package('docker-compose').with_ensure('1.4.2')
    end
  end

  context 'ensure => absent' do
    let(:params) { test_params.merge(:ensure => 'absent') }

    it do
      should contain_package('docker-compose').with_ensure(:absent)
    end
  end
end
