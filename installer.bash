#!/usr/bin/env bash

function main {
	if [ -z "$1" ]
	then
		throw "Usage: xck-install xkc.conf"
	fi
	if [ -z "$EDITOR" ]
	then
		throw "Error: \$EDITOR is not set"
	fi

	source "$1"
	if [ "$?" -ne 0 ] || \
	   [ -z "$XCB_VERSION" ] || \
	   [ -z "$XCB_NAME" ] || \
	   [ -z "$XCB_DESCRIPTION" ] || \
	   [ -z "$XCB_EVDEV_FILE" ] || \
	   [ -z "$XCB_LAYOUT_FILE" ] || \
	   [ -z "$XCB_EVDEV" ] || \
	   [ -z "$XCB_LAYOUT" ]
	then
		throw "Error: $1 is not valid xkc.conf file"
	fi

	if echo_copy "$XCB_EVDEV" "$XCB_EVDEV_FILE" "$EDITOR" && echo_copy "$XCB_LAYOUT" "$XCB_LAYOUT_FILE" "$EDITOR"
	then
		echo "done"
	fi
}

function check {
	local _text=$1
	local _file=$2
	local _message=$3
}

function echo_copy {
	local _text=$1
	local _file=$2
	local _editor=$3
	echo "-> Copy the below text:"
	echo "$_text"
	echo "-> Copy the above text, then press enter and insert it into the right place"
	read
	"$_editor" "$_file"
}

function throw {
	echo $@
	exit 1
}

main $@
