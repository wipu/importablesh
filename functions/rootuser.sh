import die

is-root() {
    [ "root" == $(whoami) ]
}

require-root() {
   is-root || die "You need to run this as root (rest assured: root privileges will be dropped wherever possible)"
}

require-user() {
    is-root && die "Refusing to run as root" || log "Ok, not running as root"
}
