# Public: Install Docker Machine

class docker::machine(
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

}
