import init-testarea
import will-consume
import log
import runtest

init-testarea

test-start "on first call to will-consume the artifact will be produced"

produce-X() {
    X=$TESTAREA/x
    log "Creating X at $X"
    echo "x content" > "$X"
}

will-consume X
[ "$TESTAREA/x" == "$X" ]
cat "$X" | grep "x content"

test-start "on second call no production will happen"

produce-X() {
    die "Unexpected call!"
}

will-consume X
