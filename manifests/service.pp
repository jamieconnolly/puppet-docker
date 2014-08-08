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
    if $ensure == 'present' {
      exec { 'init-boot2docker-vm':
        command     => 'boot2docker init',
        environment => ["BOOT2DOCKER_DIR=${datadir}", "BOOT2DOCKER_PROFILE=${configdir}/profile"],
        require     => Package['boxen/brews/boot2docker'],
        user        => $user,
        unless      => 'boot2docker status',
        before      => Service['docker'],
        notify      => Service['docker'];
      }
    } elsif $ensure == 'absent' {
      exec { 'delete-boot2docker-vm':
        command     => 'boot2docker delete',
        environment => ["BOOT2DOCKER_DIR=${datadir}", "BOOT2DOCKER_PROFILE=${configdir}/profile"],
        onlyif      => 'boot2docker status',
        require     => Package['boxen/brews/boot2docker'],
        user        => $user,
        before      => Service['docker'],
        notify      => Service['docker'];
      }
    }
  }

  service { $service:
    ensure => $service_ensure,
    enable => $enable,
    alias  => 'docker',
  }

}
