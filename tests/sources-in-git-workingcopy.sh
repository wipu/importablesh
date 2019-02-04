import cache
import die
import init-testarea
import sources-in-git-workingcopy
import runtest

init-testarea

test-start "sources means: all versioned and unadded files plus their parents (parents needed to detect deletion of sources)"

pushd "$TESTAREA"

git init
mkdir dir1 dir2 target
echo a > dir1/a
echo b > dir2/b
echo c > target/c
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

expected-out() {
    cat <<EOF
$TESTAREA
$TESTAREA/.gitignore
$TESTAREA/dir1
$TESTAREA/dir1/a
$TESTAREA/dir2
$TESTAREA/dir2/b
$TESTAREA/unadded
$TESTAREA/unadded/file
EOF
}

diff <(sources-in-git-workingcopy "$TESTAREA") <(expected-out)
