# Public: Install Docker Compose

class docker::compose(
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
