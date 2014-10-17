# Internal: Manage configuration files for docker

class docker::config(
  $ensure = undef,
  $configdir = undef,
  $datadir = undef,
  $user = undef,
) {

  $dir_ensure = $ensure ? {
    present => directory,
    default => absent,
  }

  File {
    ensure => $ensure,
    owner  => $user,
  }

  file { [$configdir,
          $datadir]:
    ensure => $dir_ensure,
    force  => true,
    links  => follow,
  }

  if $::osfamily == 'Darwin' {
    boxen::env_script { 'docker':
      ensure   => $ensure,
      content  => template('docker/darwin/env.sh.erb'),
      priority => 'lower',
    }

    file { "${configdir}/profile":
      ensure  => $ensure,
      content => template('docker/darwin/profile.erb'),
    }
  }

}
