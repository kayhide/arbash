die() {
    if [[ -n ${1:-} ]]; then
        >&2 echo "$1"
    fi
    if [[ ! -t 0 ]]; then
        while read -r line; do
            >&2 echo "$line"
        done
    fi
    exit 1
}

say_status() {
    local status="$1"
    local body="$2"
    local color="${3:-}"
    if [[ -n $color ]]; then
        tput setaf "$color"
    else
        case $status in
            create ) tput setaf 2 ;;
            delete ) tput setaf 1 ;;
            update ) tput setaf 3 ;;
            * ) tput setaf 6 ;;
        esac
    fi
    printf "% 14s " $status
    tput sgr0
    echo $body
}

parse_args() {
    args=()
    opts=()
    while (( 0 < ${#} )); do
        if [[ $1 =~ --(.*) ]]; then
            local key="${BASH_REMATCH[1]}"
            if [[ -n ${2:-} ]]; then
                opts[$key]="$2"
                shift
            else
                opts[$key]=1
            fi
        else
            args+=($1)
        fi
        shift
    done
}

fetch_arg() {
    local i="$1"
    local name="$2"
    local v="${args[$i]:-}"
    if [[ -z $v ]]; then
        if [[ -z ${3+x} ]]; then
            die "Missing argument: $name"
        fi
        echo "$3"
    else
        echo "$v"
    fi
}


verify_git_repo() {
    if ! git status 1>&2 > /dev/null; then
        die "Not in git repository"
    fi
    if [[ -z ${opts[force]+x} ]] && ! git diff --quiet; then
        die <<EOF
Your git working space is not clean.
If it is intended, run with --force option.

EOF
    fi
}
