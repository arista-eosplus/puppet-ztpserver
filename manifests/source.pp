# == Class: ztpserver::source
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
class ztpserver::source (
  $version = master,
  $repo    = 'https://github.com/arista-eosplus/ztpserver',
  $branch  = $version,
  $force   = 'false',
  $user    = 'ztpsadmin',
  $group   = 'ztpsadmin',
  $homedir = '',
  $srcdir  = '',
){

  #$sources = ['pypi', 'source']
  #validate_re($version, '/\d+(\.\d+)+/')
  #validate_string($source, $sources)

  if $homedir {
    $home_dir = $homedir
  } else {
    $home_dir = "/home/${user}"
  }

  if $srcdir {
    $src_dir = $srcdir
  } else {
    $src_dir = "${home_dir}/src"
  }

  ensure_resource('package', 'git', {'ensure' => 'installed'})

  vcsrepo { "${src_dir}/ztpserver":
    ensure   => present,
    provider => git,
    force    => $force,  # clobber dest path if it previously existed
    source   => $repo,
    revision => $branch,
    owner    => $user,
    group    => $group,
    #require  => File[$src_dir],
  }

  exec { 'Python install ztpserver':
    path    => '/usr/bin',
    cwd     => "${src_dir}/ztpserver",
    command => 'python setup.py install',
    creates => '/usr/local/bin/ztps',
    #creates => '/usr/share/ztpserver',
    require => Vcsrepo["${src_dir}/ztpserver"],
  }

  file { '/usr/local/bin/ztps':
    ensure  => present,
    require => Exec['Python install ztpserver'],
    mode    => '0755',
  }

}
