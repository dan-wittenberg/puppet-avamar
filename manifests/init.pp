# == Class: avamar
#
# @summary Manage the installation, configuration, registration  for Avamar
#
# This module will manage the installation, configuration, registration and
# service(s) for the Avamar backup software.  This class assumes that you have
# setup a repository containing the Avamar packages as this class does not
# create any repository resources since Avamar packages are not available
# for download without a license.
#
# === Authors
#
# Eric B
# Daniel Wittenberg <dan.wittenberg@thinkahead.com>
#
# === Copyright
#
# Copyright 2017
#
# === Parameters
# @param admin_server Avamar Administration Server
# [admin_server] (String: default 'ben061012.example.com')
# Avamar Administration Server
#
# @param class_enabled Enables/Disables the management of any Avamar packages, files, etc.
# [class_enabled] (Boolean: default false)
# Enables/Disables the management of any Avamar packages, files, etc.
# This option will still function, but will be deprecated in the future in
# favor of the $manage_package, $manage_register, and $manage_service options.
#
# @param manage_package Should the class control whether the package(s)
# [manage_package] (Boolean: default true)
# Should the class control whether the package(s)
#
# @param manage_register Should the class try to register the Avamar client with the admin server
# [manage_register] (Boolean: default true)
# Should the class try to register the Avamar client with the admin server
#
# @param manage_service Should the class control the Avamar service
# [manage_service] (Boolean: default true)
# Should the class control the Avamar service
#
# @param package_ensure he ensure value for the package resource
# [package_ensure] (String: default 'installed')
# The ensure value for the package resource
#
# @param package_name Name of the package to be installed/required
# [package_name] (String: default 'AvamarClient')
# Name of the package to be installed/required.
#
# @param rman_package_ensure The ensure value for the Oracle "RMAN" package resource
# [rman_package_ensure] (String: default 'absent')
# The ensure value for the Oracle "RMAN" package resource
#
# @param rman_package_name Name of the Oracle "RMAN" package to be installed/required.
# [rman_package_name] (String: default 'AvamarRMAN')
# Name of the Oracle "RMAN" package to be installed/required.
#
# @param server_domain Avamar server domain
# [server_domain] (String: default 'ben1253')
# Avamar server domain
#
# @param service_enable Should the Avamar service be enabled on the system
# [service_enable] (Boolean: default true)
# Should the Avamar service be enabled on the system
#
# @param service_ensure The ensure value for the avamar service resource
# [service_ensure] (String: default 'running')
# The ensure value for the avamar service resource
#
# @param service_name The name of the Avamar service
# [service_name] (String: default 'avagent')
# The name of the Avamar service
#
class avamar (
  $admin_server        = 'ben061012.example.com',
  $class_enabled       = true,
  $manage_package      = true,
  $manage_register     = true,
  $manage_service      = true,
  $package_ensure      = 'installed',
  $package_name        = 'AvamarClient',
  $rman_package_ensure = 'absent',
  $rman_package_name   = 'AvamarRMAN',
  $server_domain       = 'ben1253',
  $service_enable      = true,
  $service_ensure      = 'running',
  $service_name        = 'avagent',
) {
  if empty($admin_server) {
    fail('admin_server is required.')
  }

  if empty($server_domain) {
    fail('server_domain is required.')
  }

  if $avamar::class_enabled == true {
    case $facts['kernel'] {
      'Linux': {
        include ::avamar::linux
      }
      'windows': {
        include ::avamar::windows
      }
      default : {
        fail("The OS ${facts['kernel']} is not supported by the module ${module_name}")
      }
    }
  } else {
    notice('Class disabled.')
  }
}
