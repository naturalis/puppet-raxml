# == Class: raxml
#
# Full description of class raxml here.
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
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { raxml:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class raxml(
  $CPUversion       = 'AVX',
  $version          = 'PTHREADS',
  $packages         = ['build-essential','autoconf','libmpich2-dev','mpich2','subversion','libtool','pkg-config','openjdk-6-jdk'] 
)
{
  $downloadURL  = "http://sourceforge.net/projects/raxml/files/raxml/${version}/raxml-${version}.tar.gz/download"

  package { $packages:
    ensure      => installed
  }

  if ($CPUversion == "Standard"){ 
    $_CPUversion = "" 
  }else{
    $_CPUversion = ".${CPUversion}"
    $__CPUversion = "-${CPUversion}"
  } 

  if ($version == "Sequential"){ 
    $_version = "" 
  }else{
    $_version = ".${version}"
    $__version = "-${version}"
  } 

  vcsrepo { '/opt/raxml':
    ensure   => present,
    provider => 'git',
    source   => 'https://github.com/stamatak/standard-RAxML',
  }
  
  exec { 'make raxml':
    command     => "/usr/bin/make -f Makefile${_CPUversion}${_version}.gcc",
    cwd         => "/opt/raxml",
    unless      => "/usr/bin/test -d /opt/raxml/bin",
    require     => Vcsrepo['/opt/raxml']
  }

  file { '/usr/bin/raxmlHPC':
    ensure => 'link',
    target => "/opt/raxml/raxmlHPC${__version}${__CPUversion}",
  }

  file { '/opt/raxmlinput.txt':
    ensure => 'file',
    source => "puppet:///modules/raxml/raxmlinput.txt",
  }

}
