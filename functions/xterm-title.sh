xterm-title() {
    TITLE=$1
    # only do it if running in terminal
    # so we don't make a noisy text output when redirecting
    # also, in some cases it would cause tecnical problems
    [ -t 1 ] && printf "\033]0;$TITLE\007"
}
