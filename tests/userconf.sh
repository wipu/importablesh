import cache
import userconf
import die
import runtest
import init-testarea

init-testarea
cp "$(userconf-dir)/"* "$TESTAREA"/

userconf-dir() {
    echo "$TESTAREA"
}

test-start "nonexistent file causes instruction to copy from example"

userconf-read foo 2> "$CACHED/err" && die "Should have failed"
diff "$CACHED/err" <(cat <<EOF
Please create $(userconf-dir)/foo (use $(userconf-dir)/foo.example as an example)
EOF
                    )

test-start "missing parameter causes friendly failure"

touch "$(userconf-dir)/foo"
log "Reading conf"
userconf-read foo
log "Requiring param"
userconf-require-param FOOPARAM 2> "$CACHED/err" || log "Failed as expected"
diff "$CACHED/err" <(cat <<EOF
Please define FOOPARAM in $(userconf-dir)/foo
EOF
                    )

test-start "ok case"

echo 'FOOPARAM="foo value"' > "$(userconf-dir)/foo"
userconf-read foo
userconf-require-param FOOPARAM
[ "foo value" == "$FOOPARAM" ]
