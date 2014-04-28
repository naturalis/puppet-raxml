puppet-raxml
===================

Puppet modules for deployment of raxml 
Source files are cloned from the latest branch on github:  https://github.com/stamatak/standard-RAxML

Parameters
-------------
All parameters are set as defaults in init.pp or can be overwritten using the Foreman or Hieradata

Classes
-------------
- raxml

Dependencies
-------------
- no module dependencies.


Parameters
-------------
CPUversion, Version and packages, defaults to the packages needed for compiling from source.
See README on https://github.com/stamatak/standard-RAxML for explanation about CPUversions and versions. 

```
  $CPUversion          = 'AVX',       ' Standard, AVX or SSE
  $version             = 'PTHREADS'   ' Sequential, PTHREADS or MPI
  $packages            = ['build-essential','autoconf','subversion','libtool','pkg-config','openjdk-6-jdk'] 

```

Result
-------------
raxml binary, compiled from source 
Source files, documentation and binary are in /opt/raxml
/usr/bin/raxmlHPC is a symlink to the compiled version.
raxmlinput.txt test file will be placed in /opt

Usage Example for running on 8 Cores ( -T 8 )
```
raxmlHPC -p 1000000 -s /opt/raxmlinput.txt -n test.out -m PROTCATWAG -T 8
```

Limitations
-------------
This module has been built on and tested against Puppet 3 and higher.

The module has been tested on:
- Ubuntu 12.04LTS


Authors
-------------
Author Name <hugo.vanduijn@naturalis.nl>

