# Public: Installs a vagrant plugin, with license support.
#
# Usage:
#
#   vagrant::plugin { 'vmware-fusion': license => 'puppet:///some/license' }
#
#   vagrant::plugin { 'boxen': ensure => absent }

define vagrant::plugin(
  $ensure  = 'present',
  $force   = false,
  $license = undef,
  $plugin_name = $name,
) {
  include vagrant
  include boxen::config

  if $license {
    file { "/Users/${::boxen_user}/.vagrant.d/license-${plugin_name}.lic":
      ensure  => $ensure,
      mode    => '0644',
      source  => $license,
      replace => $force
    }
  }

  vagrant_plugin { $plugin_name:
    ensure => $ensure
  }
}
