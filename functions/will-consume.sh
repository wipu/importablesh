import log

will-consume() {
    local NAME=$1
    [ ${!NAME:-x} == "x" ] && {
	log "Producing $NAME"
	produce-$NAME
    } || true
}
