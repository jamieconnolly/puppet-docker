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
    ensure    => $ensure,

    configdir => $configdir,
    datadir   => $datadir,
    user      => $user,

    version   => $version,

    service   => $service,
    enable    => $enable,
  }

}
