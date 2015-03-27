# == Class: krb5
#
# This is the krb class, it will manage the krb5.conf file. You can also supply
# a keytab file which will be deployed to /etc/krb5.keytab
#
# === Authors
#
# Christopher Johnson - cjohn@ceh.ac.uk
#
class krb5 (
  $default_realm    = undef,
  $dns_lookup_realm = 'false',
  $dns_lookup_kdc   = 'false',
  $ticket_lifetime  = '24h',
  $renew_lifetime   = '7d',
  $forwardable      = 'true',
  $keytab           = undef,
  $config_file      = '/etc/krb5.conf'
) {

  if $keytab {
    file {'/etc/krb5.keytab' :
      source => $keytab,
      owner  => 'root',
      group  => 'root',
      mode   => 0600,
    }
  }

  concat { $config_file :
    ensure => present,
    owner => 'root',
    group => 'root',
    mode  => 0644,
  }

  concat::fragment { 'krb5_header':
    target  => $config_file,
    order   => '01',
    content => template('krb5/krb5.conf.erb')
  }
  
  concat::fragment{'krb5_domain_header':
    target  => $config_file,
    order   => '02',
    content => "[domain_realm]\n"
  }
  
  concat::fragment{'krb5_realms_header':
    target  => $config_file,
    order   => '04',
    content => "\n[realms]\n"
  }
}
