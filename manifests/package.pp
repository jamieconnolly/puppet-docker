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

  if $::osfamily == 'Darwin' {
    homebrew::formula { 'docker': }
  }

  package { $package:
    ensure => $package_ensure
  }

  if $::osfamily == 'Darwin' {
    homebrew::formula { 'boot2docker': }

    package { 'boxen/brews/boot2docker':
      ensure => $package_ensure
    }
  }

}
