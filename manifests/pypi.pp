# == Class: ztpserver::pypi
#
# Full description of class ztpserver here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the function of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'ztpserver':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Arista EOS+ CS <eosplus-dev@arista.com>
#
# === Copyright
#
# Copyright 2015 Arista Networks, unless otherwise noted.
#
class ztpserver::pypi (
  $version = latest
) {

  #validate_re($version, '/(latest)|(installed)|\d+(\.\d+)+/')

  package { 'python-pip':
    ensure => installed,
  }

  package{ 'ztpserver':
    ensure   => $version,
    provider => pip,
    require  => Package['python-pip'],
    #install_options => {'--flag' => 'value',}
  }

  file { '/usr/local/bin/ztps':
    ensure  => present,
    require => Package['ztpserver'],
    mode    => '0755',
  }

}
