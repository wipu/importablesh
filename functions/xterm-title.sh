xterm-title() {
    TITLE=$1
    printf "\033]0;$TITLE\007"
}
