IMPORTABLESH_IMPORTED=""

import() {
    local NAME=$1
    import-file "$IMPORTABLESH/functions/${NAME}.sh"
}

import-file() {
    local FILE=$(readlink -f "$1")
    echo "$IMPORTABLESH_IMPORTED" | grep -q ":$FILE:" && {
        return
    }
    IMPORTABLESH_IMPORTED="$IMPORTABLESH_IMPORTED:$FILE:"
    . "$FILE"
}
