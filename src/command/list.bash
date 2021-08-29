command.list.usage() {
    cat <<EOF
Usage: arbash list [NAMESPACE] [OPTIONS]

Available options:
  --help
  --fullpath

EOF
}

command.list.run() {
    local namespace
    namespace="$(fetch_arg 1 NAMESPACE "")"
    if [[ -z $namespace ]]; then
        if [[ -n ${opts[fullpath]+x} ]]; then
            find "$templates_dir" -type f
        else
            (cd "$templates_dir" && find -type f | sed -e "s|^\./||")
        fi
    else
        if [[ -n ${opts[fullpath]+x} ]]; then
            find "$templates_dir/$namespace" -type f
        else
            (cd "$templates_dir" && find "$namespace" -type f)
        fi
    fi
}
