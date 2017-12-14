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

ensure-importablesh() {
    local DEST=$CACHED/importablesh-$IMPORTABLESH_VER
    export IMPORTABLESH=$DEST
    [ -e "$DEST" ] && return

    wget "$IMPORTABLESH_ZIP_URL" -O "$DEST".zip
    unzip "$DEST".zip -d "$CACHED"
}

ensure-importablesh
. "$IMPORTABLESH"/functions/import.sh
