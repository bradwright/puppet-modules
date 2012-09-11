class osx_clock($user) {

  osx_defaults { 'clock-format':
    ensure => present,
    domain => 'com.apple.menuextra.clock',
    key    => 'DateFormat',
    value  => 'HH:mm',
    user   => $user
  }

  osx_defaults { 'clock-flash':
    ensure => present,
    domain => 'com.apple.menuextra.clock',
    key    => 'FlashDateSeparators',
    value  => 0,
    user   => $user
  }

  osx_defaults { 'clock-analog':
    ensure => present,
    domain => 'com.apple.menuextra.clock',
    key    => 'IsAnalog',
    value  => 0,
    user   => $user
  }

}
