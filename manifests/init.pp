# == Class: ztpserver
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
class ztpserver (
  $version     = master,
  $source      = 'source',
  $user        = 'ztpsadmin',
  $homedir     = '',
  $shell       = '/bin/false',
  $group       = 'ztpsadmin',
  $listen_intf = '',
  $listen_ip   = ''
){

  $sources = ['pypi', 'source']

  #validate_re($version, '/\d+(\.\d+)+/')
  validate_string($source)

  if $homedir {
    $home_dir = $homedir
    } else {
    $home_dir = "/home/${user}"
  }

  # default to the second interface
  #if $interface {
  #  $interface = $listen_intf
  #} else {
  #  $ifs = split($interfaces,",")
  #  $interface = $ifs[1]
  #}

  #if $listen_ip {
  #  $ip = $listen_ip
  #} else {
  #  $ip_var = "ipaddress_${interface}"
  #  $ip = inline_template("<%= scope.lookupvar(ip_var) %>")
  #}

  #notify { "ZTPServer will listen on interface: ${interface} (${ip})": }

  group { $group:
    ensure => present,
  }

  user { $user:
    ensure     => present,
    gid        => $group,
    managehome => true,
    home       => $home_dir,
    comment    => 'Arista ZTP Server Admin',
    #shell      => $shell,
    before     => Class['ztpserver::source'],
    # TODO: Add to sudoers
  }

  File {
    owner   => $user,
    group   => $group,
    mode    => '0664',
  }

  # Lookup the generated homedir for $user:
  #$home_var = "homedir_${user}"
  #$home = inline_template("<%= scope.lookupvar(@home_var) %>")
  #notify { "HOME is ${home}": }

  file { "${home_dir}/ztpserver":
    ensure  => link,
    target  => '/usr/share/ztpserver',
    #require => File[$home_dir],
    require => User[$user],
  }

  file { "${home_dir}/src":
    ensure  => directory,
    require => User[$user],
  }

  case $source {
    pypi:   {
      class { 'ztpserver::pypi':
        version => $version ? {
                      'master' => 'latest',
                      default  => $version,
        },
      }
    }
    source: {
      class { 'ztpserver::source':
        version => $version,
        homedir => $home_dir,
      }
    }
  }

  file {'/usr/share/ztpserver':
    ensure  => directory,
    owner   => $user,
    group   => $group,
    mode    => '2664',
    recurse => true,
    require => File['/usr/local/bin/ztps'],
  }

}
