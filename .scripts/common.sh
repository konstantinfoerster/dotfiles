#!/bin/sh

function sourceDir() {
	local dir="${1}"
        if [[ -d "${dir}" && -r "${dir}" && -x "${dir}" ]]; then
		for file in "${dir}"/?*.sh; do
		 [[ -f "${file}" && -r "${file}" ]] && source "${file}"
		done
		unset file
	fi
}

function printWithFG(){
	echo "%{F$1}$2%{F-}"
}

function printIcon() {
	echo -n -e "\u$1"
}
