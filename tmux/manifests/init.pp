# Installs the passed in version (latest stable by default) of
# Tmux. Handles the case where we need to install from source
# vs. package.
class tmux {
  if $::kernel == 'Darwin' {
    package { 'tmux':
      provider => 'brew',
      ensure   => latest,
    }
  }
  else {
    case $::lsbdistcodename {
      'precise': {
        package { 'tmux':
          ensure => latest,
        }
      }
      default: {
        class { 'tmux::src':
          version => '1.6.1',
        }
      }
    }
  }
}
