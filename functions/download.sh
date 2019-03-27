import rootuser

download() {
    local SRC=$1
    local DESTDIR=$2
    local SUM=$3
    log "download $@"
    local NAME=$(basename "$SRC")
    local DEST=$DESTDIR/$NAME
    cd "$DESTDIR"
    [ -e "$NAME" ] || {
        log "Downloading $SRC"
        require-user
        get-url-to "$SRC" "$NAME"
    }
    echo "$SUM  $NAME" | sha256sum -c || {
        local FAILED=$DEST.failed
        mv "$DEST" "$FAILED"
        log "Checksum failed, see $FAILED"
        return 1
    }
}
