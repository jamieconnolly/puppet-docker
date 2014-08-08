# Internal: Manage the docker service

class docker::service(
  $ensure = undef,

  $configdir = undef,
  $datadir = undef,
  $user = undef,

  $version = undef,

  $service = undef,
  $enable = undef,
) {

  $service_ensure = $ensure ? {
    present => running,
    default => stopped,
  }

  if $::operatingsystem == 'Darwin' {
    $command = $ensure ? {
      present => 'boot2docker init',
      default => 'boot2docker delete',
    }

    $unless = $ensure ? {
      present => 'boot2docker status | grep "machine does not exist"',
      default => 'boot2docker status',
    }

    exec { 'boot2docker':
      command     => $command,
      environment => ["BOOT2DOCKER_DIR=${datadir}", "BOOT2DOCKER_PROFILE=${configdir}/profile"],
      require     => Package['boxen/brews/boot2docker'],
      user        => $user,
      unless      => $unless,
      before      => Service['docker'],
      notify      => Service['docker'];
    }
  }

  service { $service:
    ensure => $service_ensure,
    enable => $enable,
    alias  => 'docker',
  }

}
