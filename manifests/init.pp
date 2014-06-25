# Public: Install and configure docker
#
# Examples
#
#   include docker

class docker(
  $ensure = undef,

  $configdir = undef,
  $datadir = undef,
  $executable = undef,
  $logdir = undef,
  $user = undef,

  $ip = undef,
  $port = undef,

  $package = undef,
  $version = undef,

  $service = undef,
  $enable = undef,
) {

  validate_string(
    $ensure,

    $configdir,
    $datadir,
    $executable,
    $logdir,
    $user,

    $ip,
    $port,

    $package,
    $version,

    $service,
  )

  validate_bool(
    $enable,
  )

  class { 'docker::config':
    ensure     => $ensure,

    configdir  => $configdir,
    datadir    => $datadir,
    executable => $executable,
    logdir     => $logdir,
    user       => $user,

    ip         => $ip,
    port       => $port,

    service    => $service,
    notify     => Service['docker'],
  }

  ~>
  class { 'docker::package':
    ensure  => $ensure,

    package => $package,
    version => $version,
  }

  ~>
  class { 'docker::service':
    ensure  => $ensure,

    datadir => $datadir,
    port    => $port,

    service => $service,
    enable  => $enable,
  }

}
