#!/usr/bin/env bash

function exec_cmd () {
    local LVL="$1"
    shift 1
    local CMD="$@"

    ${CMD} | \
        while read line; do
            local fdate=$(date +%y-%m-%d)
            local ftime=$(date +%H:%M:%S)
            local MSG=$(echo "${LVL} : [${fdate} ${ftime}]")
            echo "${MSG} $line";
        done
}
