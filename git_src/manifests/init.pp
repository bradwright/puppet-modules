class git_src($version) {
  package { ['asciidoc', 'xmlto']:
    ensure => installed,
  }

  file { "/tmp/install-git.sh":
    ensure => "present",
    content => template("git_src/install.sh.erb"),
    before  => Exec[ "/tmp/install-git.sh" ],
    mode => 755
  }

  exec { "/tmp/install-git.sh":
    # need unlimited timeout because the build takes ages
    timeout => 0,
    creates => "/usr/local/bin/git"
  }

  package { 'git-core':
    ensure => purged
  }
}
