import log

json-setfield() {
    local FILE=$1
    local NAME=$2
    local VALUE=$3

    log "Setting $NAME=$VALUE in json file $FILE"

    local SRC="import json, sys;o=json.load(sys.stdin);o$NAME=$VALUE;print(json.dumps(o, indent=4, sort_keys=True))"
    debuglog "  evaluating: $SRC"
    cat "$FILE" | python -c "$SRC" > "$FILE".tmp
    mv "$FILE".tmp "$FILE"
}
