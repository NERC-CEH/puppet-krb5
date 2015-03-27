# puppet-krb5

## Overview

This is the kerberos module, you can use this to manage a krb5.keytab and the krb5.conf file

## Module Description

This puppet module manages the configuration files required for using kerberos as the authentication mechanism for things like cifs mounts.

To this end, this module has been designed to compliment the [puppet-fstab](https://github.com/NERC-CEH/puppet-fstab) module.

## Setup

### What Krb5 affects

* Manages the /etc/krb5.conf file
* Deploys a /etc/krb5.keytab file

## Usage

To create an insance of tomcat

    class { 'krb5':
        default_realm => 'AD.NERC.AC.UK',
        keytab        => 'puppet:///puppet_share/keytab.file',
    }

    krb5::realm { 'AD.NERC.AC.UK':
       kdc            => 'some.ip.address',
       admin_server   => 'some.ip.address',
       default_domain => 'ad.nerc.ac.uk'
    }

## Limitations

This module has been tested on ubuntu 14.04 lts

## Contributors

Christopher Johnson - cjohn@ceh.ac.uk