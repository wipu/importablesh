import cache
import die
import init-testarea
import is-build-artifact-dirty
import runtest

init-testarea

pushd "$TESTAREA"

git init
mkdir dir1 dir2 target
echo a > dir1/a
echo b > dir2/b
cat > .gitignore <<EOF
/target/
EOF

git config user.email tester
git config user.name tester
git add -A .
git commit -m "initial commit"

mkdir unadded
echo unadded > unadded/file

popd

test-start "Missing artifact is dirty"

is-build-artifact-dirty "$TESTAREA" target/c && log Ok || die "wasn't dirty"

test-start "Artifact is nondirty after building"

sleep 1
touch "$TESTAREA"/target/c
is-build-artifact-dirty "$TESTAREA" target/c && die "wasn't nondirty" || log Ok

test-start "Artifact is dirty after touching a source"

touch "$TESTAREA"/dir1/a
is-build-artifact-dirty "$TESTAREA" target/c && log Ok || die "wasn't dirty"

test-start "Artifact is dirty after removing a source"

# first make it nondirty by building
sleep 1
touch "$TESTAREA"/target/c
is-build-artifact-dirty "$TESTAREA" target/c && die "wasn't nondirty" || log Ok
# then:
rm "$TESTAREA"/dir2/b
is-build-artifact-dirty "$TESTAREA" target/c && log Ok || die "wasn't dirty"
