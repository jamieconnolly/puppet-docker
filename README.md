# Docker Puppet Module for Boxen
[![Build Status](https://travis-ci.org/boxen/puppet-docker.svg)](https://travis-ci.org/boxen/puppet-docker)

Installs [Docker](https://www.docker.io), an easy, lightweight virtualized environment for portable applications.

## Usage

```puppet
include docker
```

## Required Puppet Modules

* `boxen`
* `homebrew`
* `ripienaar/puppet-module-data`
* `stdlib`

## Development

Write code. Run `script/cibuild` to test it. Check the `script`
directory for other useful tools.
