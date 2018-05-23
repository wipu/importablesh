import init-testarea
import is-done
import runtest

init-testarea

test-start "By default is-done is false"

is-done "$TESTAREA"/nonexistent && die "Wasn't false"

# this happens when building of file failed before mark-done:
test-start "is-done is false even if file exists but touchfile doesn't"

TARGET="$TESTAREA"/half-done
touch "$TARGET"

is-done "$TARGET" && die "Wasn't false"

test-start "is-done removes half-done target file if touchfile doesn't exist"

TARGET="$TESTAREA"/half-done
touch "$TARGET"

is-done "$TARGET" && die "Wasn't false"
[ -e "$TARGET" ] && die "Didn't remove half-done target file"

test-start "is-done is true when touchfile exists"

TARGET="$TESTAREA"/ready
TOUCHFILE="$TARGET".done
touch "$TARGET"
touch "$TOUCHFILE"

is-done "$TARGET" || die "Wasn't true"
[ -e "$TARGET" ] || die "Target file no more exists"
[ -e "$TOUCHFILE" ] || die "Touchfile no more exists"

test-start "mark-done creates touchfile"

TARGET="$TESTAREA"/ready
TOUCHFILE="$TARGET".done
touch "$TARGET"
rm -rf "$TOUCHFILE"

mark-done "$TARGET"

[ -e "$TOUCHFILE" ] || die "Touchfile still doesn't exist"
[ -e "$TARGET" ] || die "Target file no more exists"
