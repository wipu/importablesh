import log

git-clone() {
    local DESTDIR=$1
    local REPO=$2
    local COMMIT=$3

    local REPONAME=$(basename "$REPO")
    local CLONE=$DESTDIR/$REPONAME-$COMMIT

    [ -e "$CLONE" ] && return

    log "Cloning $REPO to $CLONE.tmp"
    rm -rf "$CLONE".tmp
    git clone "$REPO" "$CLONE".tmp
    cd "$CLONE".tmp
    log "Checking out $COMMIT"
    # TODO why doesn't set -eu work here to prevent continuing:
    git checkout "$COMMIT" && {
	rm -rf .git
	cd -
	debuglog "Moving the clone to $CLONE"
	mv "$CLONE"{.tmp,}
    } || {
	errorlog "Failed to checkout $COMMIT (Left clone for investigation at $CLONE.tmp)"
	cd -
	return 1
    }
}
