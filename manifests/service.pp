# Internal: Manage the docker service

class docker::service(
  $ensure = undef,

  $datadir = undef,
  $port = undef,

  $service = undef,
  $enable = undef,
) {

  $service_ensure = $ensure ? {
    present => running,
    default => stopped,
  }

  if $::operatingsystem == 'Darwin' {
    exec { 'init-boot2docker-vm':
      command     => "boot2docker init --dockerport=${port}",
      before      => Service[$service],
      environment => "BOOT2DOCKER_DIR=${datadir}",
    }
  }

  service { $service:
    ensure => $service_ensure,
    enable => $enable,
    alias  => 'docker',
  }

}
