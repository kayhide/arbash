command.path.usage() {
    cat <<EOF
Usage: arbash path [OPTIONS]

Available options:
  --help
  --root-dir
  --templates-dir

EOF
}

command.path.run() {
    local name file
    if [[ -n ${opts[root-dir]+x} ]]; then
        echo "$root_dir"
    fi
    if [[ -n ${opts[templates-dir]+x} ]]; then
        echo "$templates_dir"
    fi
    if (( ${#opts[@]} == 0 )); then
        cat <<EOF
root-dir: $root_dir
templates-dir: $templates_dir

EOF
    fi
}
