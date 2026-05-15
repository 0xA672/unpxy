unpxy() {
  (
    unset http_proxy https_proxy HTTP_PROXY HTTPS_PROXY \
          all_proxy ALL_PROXY no_proxy NO_PROXY
    exec "$@"
  )
}
