import log

testarea-location() {
    echo $IMPORTABLESH_USERDIR/testarea/$USER
}

init-testarea() {
    TESTAREA=$(testarea-location)
    TESTAREA=$(readlink -f "$TESTAREA")
    log "Initializing testarea at $TESTAREA"
    rm -rf "$TESTAREA"
    mkdir -p "$TESTAREA"
}
