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