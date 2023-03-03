#!/usr/bin/zsh
# written for bash/zsh

# note: in function promptYesNo, there exists a possible execution path
# leading to program termination
# In order for this path to have any chance to get executed, though, promptYesNo must be
# called with a second parameter


function getInputFile() {
	# TODO: implement
	exit -1;
	

	## Adapt this algorithm from reekee
	#local tries
	#tries=7
	#while [ -z "$in_password_file" ] || [ -e "$in_password_file" ]; do
		#[[ $tries -le 0 ]] && crash 2 "(infinite loop safeguard) failed to find a file for our input password within the alloted number of tries";

		#in_password_file="~/tmp$RANDOM"
		#tries=$(( $tries - 1 ))
	#done
}

# TODO: instead of reading a line, read just one key
function anyKeyContinue() {
	local noop

	echo 'Press any key to continue... '
	read noop

	echo
}


## Usage: promptYesNo ['prompt'] [onFailure_exit_code]
## if onFailure_exit_code is supplied, then if we fail to get a valid y/n/yes/no
## answer after $tries attempts, then we will call 'exit [onFailure_exit_code]'
##
## when onFailure_exit_code is NOT supplied, then exceeding $tries attempts
## to get a response will cause promptYesNo to return 2
function promptYesNo() {
	local tries
	tries=3
	local prompt
	local ans
	ans=''
	prompt=''

	[ ! -z ${WD_SWASSEMBLY+x} ] && prompt="$prompt$WD_SWASSEMBLY: "
	[ ! -z ${WD_SWCOMPONENT+x} ] && prompt="$prompt$WD_SWCOMPONENT: "

	if [ "$#" -ne 0 ]; then
		prompt=""$prompt""$1""
	fi

	prompt="$prompt (y/n/yes/no) "

	while [[ ! "$ans" =~ ^([yYnN]|[yY][eE][sS]|[nN][oO])$ ]] && [ $tries -gt 0 ]; do
		echo -n "$prompt"
		read ans
		tries=$(( $tries - 1 ))
	done

	# If we ran out of tries AND a second argument to promptYesNo was supplied
	if [ $tries -le 0 ]; then
		if [ $# -ge 2 ]; then
			exit $2;
		else
			exit 2;
		fi
	fi
	# Note: in the case where we ran out of tries but no second argument was supplied,
	#   execution will continue and promptYesNo will return false

	if [[ "$ans" =~ ^([yY]|[yY][eE][sS])$ ]]; then
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


