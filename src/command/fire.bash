#!/usr/bin/env bash

command.fire.usage() {
    cat <<EOF
Usage: arbash fire NAME [OPTIONS]

Available options:
  --help

EOF
}

# Because an user will hand arguments via environment variables,
# try argument names not to conflict.
command.fire.run() {
    local name__ file__
    verify_git_repo
    name__="$(fetch_arg 1 NAME)"
    file__="$templates_dir/$name__"
    if [[ ! -f $file__ ]]; then
        die "Missing template: $name__"
    fi

    envsubst < "$file__" | patch -p1
}
