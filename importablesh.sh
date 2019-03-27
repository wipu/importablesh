# to be imported

# This is the bootstrapper of importablesh
# The newest version is available at https://raw.githubusercontent.com/wipu/importablesh/master/importablesh.sh
# Released under the MIT license

set -euo pipefail

IMPORTABLESH_VER=fdfaae34ca127c015190fdbba69f123007570711
IMPORTABLESH_ZIP_URL=https://github.com/wipu/importablesh/archive/$IMPORTABLESH_VER.zip

IMPORTABLESH_USERDIR=$(readlink -f "$(dirname "$BASH_SOURCE")")

export CACHED=$IMPORTABLESH_USERDIR/cached
mkdir -p "$CACHED"

get-url-to() {
    local FROM=$1
    local TO=$2
    type wget >/dev/null && {
	wget "$FROM" -O "$TO"
    } || {
	curl -L "$FROM" -o "$TO"
    }
}

ensure-importablesh() {
    local DEST=$CACHED/importablesh-$IMPORTABLESH_VER
    export IMPORTABLESH=$DEST
    [ -e "$DEST" ] && return

    get-url-to "$IMPORTABLESH_ZIP_URL" "$DEST".zip
    unzip "$DEST".zip -d "$CACHED"
}

ensure-importablesh
. "$IMPORTABLESH"/functions/import.sh
