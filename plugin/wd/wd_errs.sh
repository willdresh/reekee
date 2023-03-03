#!/usr/bin/zsh

function err_print_basic() {
	echo -n "$@" >&2
}

function err_println_basic() {
	echo "$@" >&2
}

function err_print() {
	err_print_basic "[$$]"
	[ ! -z ${WD_SWASSEMBLY+x} ] && err_print_basic " $WD_SWASSEMBLY:"
	[ ! -z ${WD_SWCOMPONENT+x} ] && err_print_basic "$WD_SWCOMPONENT:"
	err_print_basic " $@"
}

function err_println() {
	[[ $# != 0 ]] && err_print "$@"
	err_println_basic ''
}

function warn() {
	err_print "WARNING: "
	if [[ $# == 0 ]]; then
		err_println_basic 'Unspecified warning'
		return 1
	else
		err_println_basic "$@"
	fi

	return 0
}

function crash() {
	local exitCode
	local exitMsg
	local default_crash_exitcode
	default_crash_exitcode=102

	if [ $# -gt 0 ]; then
		exitMsg="exit code $1"
		exitCode=$1
		shift 1
	else
		exitMsg="exit code unspecified; assuming default ($default_crash_exitcode)"
		exitCode=default_crash_exitcode
	fi


	err_println "crash reported"

	[ $# -gt 0 ] && \
		( err_println_basic "   crash info: $@"; err_println_basic )

	err_println "exiting; $exitMsg"

	exit $exitCode
}

function crashland() {
	err_println "crashland was called"
	crash "$@"
}
