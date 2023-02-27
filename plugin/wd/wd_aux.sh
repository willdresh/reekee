#!/usr/bin/zsh

# TODO: instead of reading a line, read just one key
function anyKeyContinue() {
	local noop

	echo 'Press any key to continue... '
	read noop

	echo
}

function promptYesNo() {
	local prompt
	local ans
	ans=''

	[ ! -z ${WD_SWASSEMBLY+x} ] && echo -n "$WD_SWASSEMBLY: "
	[ ! -z ${WD_SWCOMPONENT+x} ] && echo -n "$WD_SWCOMPONENT: "

	if [[ "$#" -gt 0 ]]; then
		prompt="$1 (y/n/yes/no) "
		shift 1
	else
		prompt="(y/n/yes/no) "
	fi

	while [[ ! $ans =~ ^([yYnN]|[yY][eE][sS]|[nN][oO])$ ]]; do
		echo -n "$prompt"
		read ans
	done

	if [[ $ans =~ ^([yY]|[yY][eE][sS])$ ]]; then
		return 1;
	else
		return 0;
	fi
}

function confirmContinue() {
	return promptYesNo 'Continue execution?'
}

function printSeedPrompt() {
	echo 'GPG will now prompt you to enter and confirm a "password" (actually, our seed value)'
	echo 'Please note that whatever you enter should be...
		(1) securely generated; should
		(2) contain as much entropy as possible (up to 512 bits), and should
		(3) be FORGOTTEN IMMEDIATELY after key creation'
	echo ''
}

function printSeedAdditionalInfo() {
	echo 'This value will NOT actually be used as a password; rather, its purpose is to assist in generating a cryptographically-secure seed value.'
	echo 'This seed value should remain unknown everyone; it should not be memorized or recorded at all'
	echo ''
}


