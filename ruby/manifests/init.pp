class ruby {

  case $::lsbdistcodename {
    'lucid': {
      # This uses the brightbox "ruby next generation" package, which
      # isn't a vanilla build. See:
      # http://wiki.brightbox.co.uk/docs:ruby-ng

      # Note that ruby1.9.3 is part of Precise now.
      apt::ppa { 'ppa:brightbox/ruby-ng':
        before => Package['ruby1.9.3'],
      }
    }
    default: {}
  }

  package { 'ruby1.9.3':
    ensure => installed
  }

}
