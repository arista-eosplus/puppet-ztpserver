# ztpserver

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with ztpserver](#setup)
    * [What ztpserver affects](#what-ztpserver-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with ztpserver](#beginning-with-ztpserver)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

Install and manage Arista [ZTP Server](http://ztpserver.readthedocs.org/) on linux systems.  ZTP Server requires Python 2.7 or higher.

## Module Description

Aristaentworks-ztpserver module will ensure a ztpsadmin user/group exists and install ZTP Server from PyPI or Source.

## Setup

### What ztpserver affects

* User/Group ztpsadmin
  $HOME to checkout the source repo when performing a source install
* /etc/ztpserver/
* /usr/share/ztpserver/

### Setup Requirements **OPTIONAL**

Ztpserver module requires puppetlabs-stdlib and vcsrepo modules.  Additionally, ZTP Server requires a minimum of Python 2.7.

If enabling ZTP Server to run in production via WSGI, then the puppetlabs-apache module is also required.

### Beginning with ztpserver

```
sudo puppet module install aristanetworks-ztpserver
sudo puppet apply -e ‘ztpserver'

```

## Usage

```
class { ‘ztpserver’:
  source      => pypi,
  version     => ‘v1.3.1’,
}
```

```
class { ‘ztpserver’:
  source      => source,
  version     => ‘develop’,
  user        => ‘ztpsadmin’,
  group       => ‘ztpsadmin’,
  homedir     => ‘/home/ztpsadmin’,
  shell       => ‘/bin/false’,
  listen_intf => ‘eth0’,
  listen_ip   => ‘192.168.0.2’,
}
```

## Reference

Here, list the classes, types, providers, facts, etc contained in your module.
This section should include all of the under-the-hood workings of your module so
people know what the module is touching on their system but don't need to mess
with things. (We are working on automating this section!)

## Limitations

Tested on RedHat and Debian linux distros.  Distro MUST have Python 2.7 or higher pre-installed.

## Development

Contributions are welcome through issues and pull requests.  Please ensure that submissions include spec tests.

## Changelog

See the [CHANGELOG.md](CHANGELOG.md)

