#!/usr/bin/env bash

command.create.usage() {
    cat <<EOF
Usage: arbash create NAME [REF] [OPTIONS]

Available options:
  --help
  --force
  --skip-edit

EOF
}

command.create.run() {
    local name ref dst
    verify_git_repo

    name="$(fetch_arg 1 NAME)"
    ref="$(fetch_arg 2 REF HEAD)"

    dst="$templates_dir/$name"
    mkdir -p $(dirname $dst)
    if [[ -e $dst && -z ${opts[force]+x} ]]; then
        die <<EOF
Already exists: $name
If it is intended, run with --force option.

EOF
    fi

    git diff "$ref~1" "$ref" > "$dst"
    if [[ -z ${opts[skip-edit]+x} ]]; then
        edit $name
    fi
    say_status create "$name"
}
