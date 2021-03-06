#!/bin/bash -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

usage() {
cat <<EOF
Usage:
tests.sh run
tests.sh acceptance
tests.sh help
EOF
	exit 1
}

cmd-run-acceptance() {
  cd ${DIR}/../test/acceptance && \
    npm install && \
    npm test
}

cmd-run-test() {
	local repo=$1;
	cd ${DIR}/../repos/${repo} && make test
}

cmd-run-tests() {
	local repodir="${DIR}/../repos/*"
	for dir in $(ls -d $repodir); 
  do
  	if [[ -d $dir ]]; then
    	cmd-run-test `basename $dir`
    fi
  done
}

main() {
	case "$1" in
	run)					      	shift; cmd-run-tests $@;;
  acceptance)           shift; cmd-run-acceptance $@;;
	*)                    usage $@;;
	esac
}

main "$@"
