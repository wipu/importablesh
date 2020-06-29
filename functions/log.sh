printlog() {
  echo "- $@" >&2
}

log() {
  logcolor 1
  logcolor 34
  printlog "$@"
  logcolor 0
}

errorlog() {
  logcolor 1
  logcolor 31
  printlog "$@"
  logcolor 0
}

debuglog() {
  logcolor 36
  printlog "$@"
  logcolor 0
}

yippielog() {
  logcolor 32
  printlog "$@"
  logcolor 0
}

logcolor() {
  if [ -t 2 ]; then printf "\033[${1}m" >&2; fi
}
