import init-testarea
import log
import download
import runtest

init-testarea

# This is duplicated from importablesh.sh, because it is not called
# when running these tests.
# No reuse is attempted, to keep the bootstrap simple.
get-url-to() {
    local FROM=$1
    local TO=$2
    type wget &>/dev/null && {
	wget "$FROM" -O "$TO"
    } || {
	curl -L "$FROM" -o "$TO"
    }
}

SRC=$TESTAREA/src
echo "file content" > "$SRC"

type wget || die "This test assumes we have wget installed."

wget() {
    log "Mock downloading $1 to $(pwd)"
    cp "$1" ./
}

DL1=$TESTAREA/dl1
mkdir "$DL1"
DL2=$TESTAREA/dl2
mkdir "$DL2"

test-start "successful download"

download "$SRC" "$DL1" "694b27f021c4861b3373cd5ddbc42695c056d0a4297d2d85e2dae040a84e61df"

cmp "$SRC" "$DL1/src"

test-start "wrong checksum"

download "$SRC" "$DL2" "794b27f021c4861b3373cd5ddbc42695c056d0a4297d2d85e2dae040a84e61df" && die "Checksum should have failed" || log "Got failure as expected"

[ -e "$DL2/src" ] && die "Downloaded file should not exist"
[ -e "$DL2/src.failed" ] || die "Copy of downloaded file should exist"

test-start "no download happens when cached file exists"

wget() {
    die "Unexpected download"
}
download "$SRC" "$DL1" "694b27f021c4861b3373cd5ddbc42695c056d0a4297d2d85e2dae040a84e61df"

# cleanup: resume normal wget operation
unset wget
