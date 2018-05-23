import log

is-done() {
    local TARGET=$1
    [ -e "$TARGET".done ] && {
	log "Already done: $TARGET"
	return 0
    }
    [ -e "$TARGET" ] && {
	log "Removing partly done $TARGET"
	rm -rf "$TARGET"
    }
    return 1
}

mark-done() {
    local TARGET=$1
    log "Marking done: $TARGET"
    touch "$TARGET".done
}
