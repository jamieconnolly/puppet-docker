# Internal: Manage the docker service

class docker::service(
  $ensure = undef,
  $configdir = undef,
  $datadir = undef,
  $enable = undef,
  $service = undef,
  $user = undef,
) {

  $service_ensure = $ensure ? {
    present => running,
    default => stopped,
  }

  if $::osfamily == 'Darwin' {
    $command = $ensure ? {
      present => 'boot2docker init',
      default => 'boot2docker delete',
    }

    $unless = $ensure ? {
      present => 'boot2docker status',
      default => undef,
    }

    exec { 'boot2docker-vm':
      command     => $command,
      environment => ["BOOT2DOCKER_DIR=${datadir}", "BOOT2DOCKER_PROFILE=${configdir}/profile"],
      require     => Package['boot2docker'],
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
