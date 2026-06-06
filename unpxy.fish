function unpxy --description 'Run a command without proxy environment variables'
    set -l proxy_vars http_proxy https_proxy HTTP_PROXY HTTPS_PROXY all_proxy ALL_PROXY no_proxy NO_PROXY

    if test (count $argv) -eq 0
        echo "Usage: unpxy [-p] <command>"
        return 1
    end

    if test "$argv[1]" = "-p"
        set -e argv[1]
        if test (count $argv) -eq 0
            echo "Usage: unpxy [-p] <command>"
            return 1
        end
        begin
            for v in $proxy_vars
                set -e $v
            end
            eval $argv
        end
    else
        begin
            for v in $proxy_vars
                set -e $v
            end
            command $argv
        end
    end
end
