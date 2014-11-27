# Public: Install and configure docker
#
# Examples
#
#   include docker

class docker(
  $ensure = undef,
  $configdir = undef,
  $datadir = undef,
  $enable = undef,
  $executable = undef,
  $logdir = undef,
  $package = undef,
  $service = undef,
  $user = undef,
  $version = undef,
) {

  validate_string(
    $ensure,
    $configdir,
    $datadir,
    $executable,
    $logdir,
    $package,
    $service,
    $user,
    $version,
  )
  validate_bool($enable)

  if $::osfamily == 'Darwin' {
    include boxen::config
  }

  class { 'docker::config':
    ensure     => $ensure,
    configdir  => $configdir,
    datadir    => $datadir,
    executable => $executable,
    logdir     => $logdir,
    service    => $service,
    user       => $user,
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
    enable    => $enable,
    service   => $service,
    user      => $user,
  }

}
