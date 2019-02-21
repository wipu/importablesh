import log

will-consume() {
    local NAME=$1
    set | grep -q "^$NAME=" || {
	log "Producing $NAME"
	produce-$NAME
    }
}
