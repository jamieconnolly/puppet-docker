# Public: Install and configure docker
#
# Examples
#
#   include docker

class docker(
  $ensure = undef,
  $configdir = undef,
  $datadir = undef,
  $package = undef,
  $user = undef,
  $version = undef,
) {

  validate_string(
    $ensure,
    $configdir,
    $datadir,
    $package,
    $user,
    $version,
  )

  if $::osfamily == 'Darwin' {
    include boxen::config
    include virtualbox
  }

  class { 'docker::config':
    ensure     => $ensure,
    configdir  => $configdir,
    datadir    => $datadir,
    user       => $user,
  }

  ~>
  class { 'docker::package':
    ensure  => $ensure,
    package => $package,
    version => $version,
  }

}
