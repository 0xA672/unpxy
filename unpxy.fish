function unpxy --description 'Run a command without proxy environment variables'
    set -l proxy_vars http_proxy https_proxy HTTP_PROXY HTTPS_PROXY all_proxy ALL_PROXY no_proxy NO_PROXY

    if test (count $argv) -gt 0 -a "$argv[1]" = "-p"
        set -e argv[1] 
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
