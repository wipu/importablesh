import git-clone
import init-testarea
import runtest

init-testarea

REPO=$TESTAREA/repo
mkdir "$REPO"
cd "$REPO"
git init
git config user.email test@test.com
git config user.name test
echo 1 > f
git add f
git commit -m "1"
echo 2 > f
git add f
git commit -m "2"
COMMIT=$(git rev-parse HEAD~1)
cd -

CLONES=$TESTAREA/clones

test-start "successful clone of given commit"

git-clone "$CLONES" "file://$REPO" "$COMMIT"

grep 1 "$CLONES/repo-$COMMIT/f"

test-start "illegal commit leaves no broken clone"

ILLEGAL_COMMIT=d3ec505102bbda6fd56d8af72c8ad47a24f962b9
git-clone "$CLONES" "file://$REPO" "$ILLEGAL_COMMIT" && die "Clone didn't fail with illegal commit" || log "Clone with illegal commit failed as expected"

[ -e "$CLONES/repo-$ILLEGAL_COMMIT" ] && die "git-clone left crap!" || log "Ok, no clone exists after failed clone"
