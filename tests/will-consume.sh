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

test-start "failure in produce causes failure in call to will-consume"

produce-FAILURE() {
    log "Failing on purpose"
    # we are setting the variable, so if the caller of will-consume ignores
    # the exit value, they will later think production is up-to-date
    # so it's important to have set -eu effective always
    export FAILURE=called
    false
}

will-consume FAILURE && die "Didn't fail!" || log "Failed as expected"
