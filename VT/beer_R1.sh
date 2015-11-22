#!/bin/bash

main(){
    ensure_program "curl"
    ensure_program "pv"
    file_address="https://raw.githubusercontent.com/wdbm/images/master/VT/beer_R1.vt"
    clear
    curl -s "${file_address}" | pv -L1600 -q
}

ensure_program(){
    program="${1}"
    command -v "${program}" >/dev/null 2>&1 || {
        echo >&2 "The program "${program}" is required. Please install it and try again."
        exit 1
    }
}

main
