# Installs node.js and npm using the chris-lea PPA. This ensures we
# have the latest stable versions.
class nodejs {

  apt::repository { 'chris-lea-nodejs':
    type  => 'ppa',
    owner => 'chris-lea',
    repo  => 'node.js',
  }

  package { 'nodejs':
    ensure => installed,
  }

  package { 'npm':
    ensure => installed,
  }

}
