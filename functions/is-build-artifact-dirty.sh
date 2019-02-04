import log
import sources-in-git-workingcopy

is-build-artifact-dirty() {
    local WC=$1
    local ARTIFACT_RELPATH=$2
    
    local ARTIFACT=$WC/$ARTIFACT_RELPATH
    log "Checking up-to-date status of $ARTIFACT ..."
    
    sources-in-workingcopy "$WC" | while read SRC; do
	[ "$ARTIFACT" -nt "$SRC" ] && true || {
		log "It is not newer than $SRC"
		echo dirty
		exit 0
	    }
    done | grep -q dirty && {
	return 0
    } || {
	log "It is up to date"
	return 1
    }
}

sources-in-workingcopy() {
    debuglog "sources-in-workingcopy delegating to sources-in-git-workingcopy, override if needed"
    sources-in-git-workingcopy "$@"
}
