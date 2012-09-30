class curl {
  if $::kernel == 'Darwin' {
    $provider = 'brew'
  }
  else {
    $provider = 'apt'
  }

  package { 'curl':
    provider => $provider,
    ensure   => latest
  }
}
