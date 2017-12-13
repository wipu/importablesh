IMPORTABLESH_USERCONF_LASTFILE="unknown file"

userconf-dir() {
    readlink -f "$IMPORTABLESH_USERDIR/userconf"
}

userconf-read() {
    local NAME=$1
    USERCONF_LASTFILE=$(userconf-dir)/$NAME
    [ -e "$USERCONF_LASTFILE" ] || {
	echo "Please create $USERCONF_LASTFILE (use $USERCONF_LASTFILE.example as an example)" >&2
	return 1
    }
    log "Reading $USERCONF_LASTFILE"
    . "$USERCONF_LASTFILE"
}

userconf-require-param() {
    local NAME=$1
    [ "${!NAME:-_undefined_}" == "_undefined_" ] && {
	echo "Please define $NAME in $USERCONF_LASTFILE" >&2
	return 1
    } || log "  OK: $NAME=${!NAME}"
}
