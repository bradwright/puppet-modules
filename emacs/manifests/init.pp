# Installs the passed in version (normally latest) of Emacs. Handles
# the case where it needs to install from source vs. package
# management.
class emacs($version='24.2') {

  case $::lsbdistcodename {
    'precise': {
      class { 'emacs::package':
        version => $version
      }
    }
    default: {
      class { 'emacs::src':
        version => $version
      }
    }
  }
}
