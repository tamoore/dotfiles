#!/usr/bin/env bash

print_log() {
	echo -e "\033[1m==>\033[0m $1"
}

colorize_output() {
	while read -r line; do
		echo "$line" |
			sed ''/ok/s//"$(printf "\033[32mok\033[0m")"/'' |
			sed ''/PASS/s//"$(printf "\033[32mPASS\033[0m")"/'' |
			sed ''/FAIL/s//"$(printf "\033[31mFAIL\033[0m")"/'' |
			sed ''/\?/s//"$(printf "\033[33m?\033[0m")"/''
	done
}