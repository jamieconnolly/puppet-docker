# Docker Puppet Module for Boxen
[![Build Status](https://travis-ci.org/boxen/puppet-docker.svg)](https://travis-ci.org/boxen/puppet-docker)

Installs [Docker](https://www.docker.io), an easy, lightweight virtualized environment for portable applications.

## Usage

```puppet
include docker
```

This module supports data bindings via hiera. See the parameters to the fig class
for overridable values.

## Updating the docker (and associated boot2docker) version

The docker version is something you should be managing in your own boxen repository,
rather than depending on this module to update for you. You can update docker by
overriding the version value with Hiera:

``` yaml
docker::version: '1.5.0'
```

You can find a list of releases for docker [here](https://github.com/docker/docker/releases),
and the associated boot2docker releases [here](https://github.com/boot2docker/boot2docker-cli/releases).

## Required Puppet Modules

* `boxen`
* `homebrew`
* `ripienaar/puppet-module-data`
* `stdlib`

## Development

Write code. Run `script/cibuild` to test it. Check the `script`
directory for other useful tools.
