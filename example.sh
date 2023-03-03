#!/usr/bin/bash

if [ ! -x './reekee' ]; then
	echo "example.sh: Error: couldn't find reekee. Please run this script from the same directory as your reekee executable"
	echo "If you are still getting this error message from the same directory as reekee, you might try executing 'chmod 755 reekee', then try again"
	exit 1
fi

if [ ! -d './test' ]; then
	echo "example.sh: Error: couldn't find test input directory. Please make sure you extracted it from example.tar to the same directory as your reekee script."
	echo "if it's already in the same directory as reekee, then try executing ' chmod 755 test; chmod 644 test/* ' first"
	exit 2
fi

myCommand='./reekee -ik test/mock-key.key -ok test/new-mock.key -ip test/in-pass -op test/out-pass -i test/TestKPCLI.kdbx --debug '
echo "example.sh: Output file will be named rekeyed.kdbx and placed into CWD"
$myCommand

echo "***********************************************************************"
echo "example.sh: I hope you have enjoyed this example. The command used was:"
echo
echo "$myCommand"
echo
echo "Please have a fantastic day!"
