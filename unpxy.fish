function unpxy --description 'Run a command without proxy environment variables'
    begin
        set -l _vars http_proxy https_proxy HTTP_PROXY HTTPS_PROXY all_proxy ALL_PROXY no_proxy NO_PROXY
        for v in $_vars
            set -e $v
        end
        command $argv
    end
end
