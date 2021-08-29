#!/usr/bin/env bash

command.delete.usage() {
    cat <<EOF
Usage: arbash delete NAME

Available options:
  --help

EOF
}

command.delete.run() {
    local name ref dst

    name="$(fetch_arg 1 NAME)"

    dst="$templates_dir/$name"
    mkdir -p $(dirname $dst)
    if [[ ! -e $dst ]]; then
        die <<EOF
Not found: $name

EOF
    fi

    rm "$dst"
    say_status delete "$name"
}
