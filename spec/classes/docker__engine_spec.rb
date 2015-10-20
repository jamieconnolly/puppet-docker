require 'spec_helper'

describe 'docker::engine' do
  let(:test_params) { {
    :ensure  => 'present',
    :package => 'docker',
    :version => '1.8.3',
  } }

  let(:facts) { default_test_facts }
  let(:params) { test_params }

  context 'ensure => present' do
    it do
      should contain_package('docker').with_ensure('1.8.3')
    end
  end

  context 'ensure => absent' do
    let(:params) { test_params.merge(:ensure => 'absent') }

    it do
      should contain_package('docker').with_ensure(:absent)
    end
  end
end
