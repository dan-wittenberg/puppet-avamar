# Class: avamar
#
# This module will allow a scheuduled task to run once on a host between the date/time specified.
# It checks if a file exists (IE: /tmp/pp.<date start> and if it does not, it will create and reboot
#
# Parameters:
#    class_enabled  (Boolean: default [false])
#    - Enables/Disables the process
#    ensure_package (Boolean: default [true])
#    - Enables/Disables package installation requirements
#    package_name (String: default AvamarClient)
#    - Name of the package to be installed/required.
#    admin_server (String)
#    - Avamar Administration Server
#    server_domain (String)
#    - Avamar server domain
#
class avamar (
  $class_enabled     = true,
  $package_name      = "AvamarClient",
  $admin_server      = 'ben061012.example.com',
  $server_domain     = 'ben1253',
) {
  # Verify if target host is Linux
  if $::kernel == 'Linux' {

    # Check if Class is disabled (Helps to disable some hosts)
    if $class_enabled == true {
      package { "AvamarClient":
        ensure => installed,
        name => "${package_name}"
      }
      $command_string = "/usr/local/avamar/etc/avagent.d register ${admin_server} ${server_domain}"
      exec { 'AVRegister':
        command => $command_string,
        user    => root,
        onlyif  => '/usr/bin/test ! -f /usr/local/avamar/var/avagent.cfg',
        path    => ['/usr/bin','/sbin'],
      }
    } else {
      notice('Class disabled.')
    }
  }
}
