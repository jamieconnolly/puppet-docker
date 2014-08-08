# Internal: Manage configuration files for docker

class docker::config(
  $ensure = undef,

  $configdir = undef,
  $datadir = undef,
  $executable = undef,
  $logdir = undef,
  $user = undef,

  $ip = undef,
  $port = undef,

  $service = undef,
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
          $datadir,
          $logdir]:
    ensure => $dir_ensure,
    force  => true,
    links  => follow,
  }

  if $::operatingsystem == 'Darwin' {
    boxen::env_script { 'docker':
      ensure   => $ensure,
      content  => template('docker/darwin/env.sh.erb'),
      priority => 'lower',
    }

    file { "${configdir}/profile":
      ensure  => $ensure,
      content => template('docker/darwin/profile.erb'),
    }

    # file { "/Library/LaunchDaemons/${service}.plist":
      # content => template('docker/darwin/docker.plist.erb'),
      # group   => 'wheel',
      # owner   => 'root',
    # }
  }

}
