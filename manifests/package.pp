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

  package { $package:
    ensure => $package_ensure
  }

  if $::osfamily == 'Darwin' {
    package { 'boot2docker':
      ensure   => $package_ensure,
      provider => homebrew,
    }
  }

}
