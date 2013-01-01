# Installs Emacs from the cassou/emacs PPA.
class emacs::package($version) {
  include apt

  apt::ppa { "ppa:cassou/emacs": }

  package { 'emacs24':
    ensure  => installed,
    require => Apt::Ppa['ppa:cassou/emacs'],
  }

  package { 'emacs':
    ensure => purged
  }
}
