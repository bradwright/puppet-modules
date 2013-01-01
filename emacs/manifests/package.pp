# Installs Emacs from the cassou/emacs PPA.
class emacs::package($version) {
  include apt

  exec { 'emacs-apt-update':
    command => 'apt-get update'
  }

  apt::ppa { "ppa:cassou/emacs":
    require => Exec['emacs-apt-update']
  }

  package { 'emacs24':
    ensure  => installed,
    require => Apt::Ppa['ppa:cassou/emacs'],
  }

  package { 'emacs':
    ensure => purged
  }
}
