# avamar::linux
#
# @summary Install and configure Avamar for Linux
#
# @example
#   include avamar::linux
class avamar::linux {

  $avamar_path = '/usr/local/avamar'
  $register_cmd = "${avamar_path}/etc/avagent.d register ${avamar::admin_server} ${avamar::server_domain}"

  # Check if Class is disabled (Helps to disable some hosts)
  if $avamar::manage_package {
    package { 'AvamarClient':
      ensure => $avamar::package_ensure,
      name   => $avamar::package_name,
    }

    package { 'AvamarRMAN':
      ensure => $avamar::rman_package_ensure,
      name   => $avamar::rman_package_name,
    }

    $reg_req = Package['AvamarClient']
    $svc_sub = Package['AvamarClient']

  } else {
    $reg_req = undef
    $svc_sub = undef
  }

  if $avamar::manage_register {
    # The onlyif test here does a check using the status
    # function.  It will return 0 if "activated" is found, *and*
    # the current name of the admin server is the same as is
    # specified to the class.  This catches both the case where
    # a machine hasn't been registered yet, or one that was
    # previously registered to another MCS and needs to be
    # re-registered with the newly specified one.
    exec { 'AVRegister':
      command => $register_cmd,
      user    => 'root',
      unless  => "${avamar_path}/etc/avagent.d status | grep 'activated' | grep '${avamar::admin_server}'",
      path    => ['/usr/bin', '/sbin', '/bin', '/usr/sbin'],
      require => $reg_req,
    }
  }

  if $avamar::manage_service {
    service { 'AvamarService':
      ensure    => $avamar::service_ensure,
      enable    => $avamar::service_enable,
      name      => $avamar::service_name,
      subscribe => $avamar::svc_sub,
    }
  }
}
