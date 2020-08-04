#!/usr/bin/env bash

command.info.usage() {
    cat <<EOF
Usage: arbash info NAME [OPTIONS]

Available options:
  --help

EOF
}

command.info.run() {
    local name file
    name="$(fetch_arg 1 NAME)"
    file="$templates_dir/$name"
    if [[ ! -f $file ]]; then
        die "Missing template: $name"
    fi
    echo "Name: $name"
    echo "Path: $file"
    echo "Arguments:"
    sed -e 's/${[^}]*}/\n\0\n/g' "$file" \
        | grep '^\$' \
        | sort \
        | uniq \
        | sed -e 's/^/  /'
}
