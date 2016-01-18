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

## Generating a .keytab file for use with the fstab module

You can use ktutil in order to generate a keytab file. On Ubuntu, ktutil is available by:

    apt-get install krb5-user

Assuming that you have configured this module to point to your krb5 realm (see usage), you will be able to generate a [ticket granting ticket](https://en.wikipedia.org/wiki/Ticket_Granting_Ticket) for a particular user.

    ktutil
    addent -password -p cjohn@AD.NERC.AC.UK -k 1 -e aes256-cts # This will prompt for your password
    wkt /etc/krb5.keytab

You can now use this keytab file for authentication. For example, you can mount a windows shared drive using the [puppet-fstab](https://github.com/NERC-CEH/puppet-fstab) module. This will require that you use the *cifs* fstype and specify the mount option `sec=krb5`.

## Limitations

This module has been tested on ubuntu 14.04 lts

## Contributors

Christopher Johnson - cjohn@ceh.ac.uk