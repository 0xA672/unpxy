# unpxy

> Run commands without proxy environment variables.

## Why?

Proxy settings (`http_proxy`, `https_proxy`, `all_proxy`, etc.) sometimes interfere with tools that connect to local services, internal mirrors, or GitHub.  
`unpxy` temporarily unsets these variables for a single command, leaving your shell environment unchanged.

## Why not just `unset` manually?

If you run `unset http_proxy` directly in your shell, the proxy is removed for the rest of the session.  
`unpxy` confines the effect to a single command, so you don’t have to remember to re‑export your proxy variables afterwards.

## Installation

Clone the repository and source the script in your `.bashrc` / `.zshrc`:
```bash
git clone https://github.com/0xA672/unpxy.git
echo "source $PWD/unpxy/unpxy.sh" >> ~/.zshrc   # or ~/.bashrc
```
Or simply copy the function into your shell config manually.

## Fish Shell

Fish users should use `unpxy.fish`:

```fish
# Add to ~/.config/fish/config.fish
source /path/to/unpxy.fish
```

## Usage
```bash
unpxy <any-command>
```

## How it works
* Creates a subshell (using parentheses)
* Unsets common proxy variables in that subshell
* Executes your command with `exec "$@"`
* After the command finishes, the subshell exits and your parent shell keeps its original proxy settings

## License

MIT — see [LICENSE](LICENSE) file.
