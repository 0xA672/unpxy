unpxy() {
    [[ $# -eq 0 ]] && { echo "Usage: unpxy [-p] [--] <command>" >&2; return 1; }
    local -a proxy_vars=(
        http_proxy https_proxy HTTP_PROXY HTTPS_PROXY
        all_proxy ALL_PROXY no_proxy NO_PROXY
    )
    local use_eval=0
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -p) use_eval=1; shift ;;
            --) shift; break ;;
            -*) echo "unpxy: unknown option: $1" >&2; return 1 ;;
            *) break ;;
        esac
    done
    [[ $# -eq 0 ]] && { echo "Usage: unpxy [-p] [--] <command>" >&2; return 1; }
    if (( use_eval )); then
        (
            unset "${proxy_vars[@]}"
            eval "$@"
        )
    else
        (
            unset "${proxy_vars[@]}"
            exec "$@"
        )
    fi
}
