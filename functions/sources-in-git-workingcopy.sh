sources-in-git-workingcopy() {
    local WC=$1
    debuglog "Finding sources in git workingcopy $WC"
    pushd "$WC" >/dev/null
    _source-files-in-git | while read f; do
	_print-with-parent "$f"
    done | sort | uniq
    popd >/dev/null
}

_print-with-parent() {
    local F=$(readlink -f "$1")
    echo "$F"
    dirname "$F"
}

_source-files-in-git() {
    # versioned:
    git ls-files
    # unversioned:
    git ls-files --others --exclude-standard
}
