# Installs most recent stable Git from the git-core team PPA
class git-core {
  include apt

  apt::ppa { "ppa:git-core/ppa": }

  package { 'git':
    ensure  => latest,
    require => Apt::Ppa['ppa:git-core/ppa']
  }

  package { 'git-core':
    ensure  => purged,
    require => Package['git']

  }
}
