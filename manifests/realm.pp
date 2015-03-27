# == Define: krb5::realm
#
# Defines a kerberos realm. This allows us to specify things like the ip 
# address of the kerberos key distribution center for this realm.
#
# === Authors
#
# Christopher Johnson - cjohn@ceh.ac.uk
#
define krb5::realm(
  $kdc,
  $admin_server,
  $default_domain,
  $realm            = $name,
  $config_file      = $krb5::config_file,
) {
  concat::fragment{"domain_$realm":
    target  => $config_file,
    order   => '03',
    content => template('krb5/krb5domain.erb')
  }
  
  concat::fragment{"realm_$realm":
    target  => $config_file,
    order   => '05',
    content => template('krb5/krb5realm.erb')
  }
}