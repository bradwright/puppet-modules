# Installs the passed in version (latest stable by default) of
# Tmux. Handles the case where we need to install from source
# vs. package.
class tmux($version='1.6') {
  case $::lsbdistcodename {
    'precise': {
      package { 'tmux':
        ensure => installed
      }
    }
    default: {
      class { 'tmux::src':
        version => $version
      }
    }
  }
}
