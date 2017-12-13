#!/bin/bash

set -eu

export IMPORTABLESH=$(readlink -f "$(dirname "$0")")
export IMPORTABLESH_USERDIR=$IMPORTABLESH

. "$IMPORTABLESH/functions/import.sh"

import userconf-username
require-root

import runtest

cd "$IMPORTABLESH/tests"

# first some internal test to verify root privilege dropping works
run-test-as-root running-as-root.sh
run-test-as-user running-as-user.sh

# then some less trivial tests
run-test-as-user userconf.sh
run-test-as-user will-consume.sh
run-test-as-user download.sh
run-test-as-user jsonedit.sh

yippielog "All tests passed :D"
