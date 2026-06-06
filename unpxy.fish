function unpxy --description 'Run a command without proxy environment variables'
    set -l proxy_vars http_proxy https_proxy HTTP_PROXY HTTPS_PROXY all_proxy ALL_PROXY no_proxy NO_PROXY
    if test (count $argv) -eq 0
        echo "Usage: unpxy [-p] [--] <command>" >&2
        return 1
    end
    set -l use_eval 0
    while test (count $argv) -gt 0
        switch $argv[1]
            case -p
                set use_eval 1
                set -e argv[1]
            case -h --help
                cat <<'EOF'
Usage: unpxy [-p] [--] <command>
Run a command without proxy environment variables.

Options:
  -p          Evaluate arguments as a shell expression (for pipelines, builtins)
  --          End of options; everything after is treated as the command
  -h, --help  Show this help message
EOF
                return 0
            case --
                set -e argv[1]
                break
            case '-*'
                echo "unpxy: unknown option: $argv[1]" >&2
                return 1
            case '*'
                break
        end
    end
    if test (count $argv) -eq 0
        echo "Usage: unpxy [-p] [--] <command>" >&2
        return 1
    end
    begin
        for v in $proxy_vars
            set -e $v
        end
        if test $use_eval -eq 1
            eval $argv
        else
            command $argv
        end
    end
end
