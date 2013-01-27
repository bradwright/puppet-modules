# Installs most recent stable Git from the git-core team PPA
class git-core {
  include apt

  exec { 'git-apt-update':
    command => 'apt-get update'
  }

  apt::ppa { "ppa:git-core/ppa":
    require => Exec['git-apt-update']
  }

  package { 'git':
    ensure  => latest,
    require => Apt::Ppa['ppa:git-core/ppa']
  }

  package { 'git-core':
    ensure  => purged,
    require => Package['git']

  }
}
