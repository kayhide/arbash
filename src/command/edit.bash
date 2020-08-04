#!/usr/bin/env bash

command.edit.usage() {
    cat <<EOF
Usage: arbash edit NAME [OPTIONS]

Available options:
  --help

EOF
}

command.edit.run() {
    local name file
    name="$(fetch_arg 1 NAME)"
    file="$templates_dir/$name"
    if [[ ! -f $file ]]; then
        die "Missing template: $name"
    fi
    "$EDITOR" "$file"
}
