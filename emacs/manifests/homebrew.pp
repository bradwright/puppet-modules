# Installs Emacs from source using the .tar.gz file.
class emacs::homebrew($version) {
  exec { 'homebrew emacs':
    command => "/usr/local/bin/brew install emacs-${version} --cocoa --srgb",
    unless  => "/usr/local/bin/brew list --versions emacs | grep -Fqe '${version}'",
    timeout => 0
  }
}
