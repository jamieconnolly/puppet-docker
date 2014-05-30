# Internal: Install the docker package

class docker::package(
  $ensure = undef,

  $package = undef,
  $version = undef,
) {

  $package_ensure = $ensure ? {
    present => $version,
    default => absent,
  }

  if $::operatingsystem == 'Darwin' {
    homebrew::formula { ['boot2docker', 'docker']:
      before => Package[$package],
    }
  }

  package { $package:
    ensure => $package_ensure,
  }

}
