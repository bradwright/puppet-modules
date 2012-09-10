# Installs Emacs from the cassou/emacs PPA.
class emacs::package($version) {
  apt::repository { 'emacs-cassou':
    type  => 'ppa',
    owner => 'cassou',
    repo  => 'emacs',
  }

  package { 'emacs24':
    ensure  => installed,
    require => Apt::Repository['emacs-cassou'],
  }

  package { 'emacs':
    ensure => purged
  }
}
