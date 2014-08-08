# Internal: Manage the docker service

class docker::service(
  $ensure = undef,

  $service = undef,
  $enable = undef,
) {

  $service_ensure = $ensure ? {
    present => running,
    default => stopped,
  }

  # service { $service:
    # ensure => $service_ensure,
    # enable => $enable,
    # alias  => 'docker',
  # }

}
