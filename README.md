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

```text
unpxy [-p] [--] <command>
```

- `-p` – evaluate the remaining arguments as a shell expression (needed for pipelines, redirects, etc.)
- `--` – explicitly mark the end of options; everything after it is treated as the command
- Unknown flags (e.g. `-x`) cause an error message and exit code 1

### Single command
```bash
unpxy curl -fsSL https://example.com/script.sh
```
The command runs immediately in a proxy‑free subshell.

### Piping multiple commands (Bash / Zsh)
When you need an entire pipeline to ignore the proxy, use the `-p` flag and quote the full pipeline as a single string:
```bash
unpxy -p "curl -fsSL https://example.com/script.sh | bash"
```
This ensures both the download and the execution of the script happen inside the same clean environment.

### Piping multiple commands (Fish)
Fish users can pass the pipeline in the same way, or split arguments naturally (fish’s `eval` joins them):
```fish
unpxy -p curl -fsSL https://example.com/script.sh "|" bash
# or as a single string
unpxy -p "curl -fsSL https://example.com/script.sh | bash"
```

### Error handling
Calling `unpxy` without arguments prints a usage message and returns exit code 1:
```bash
unpxy
# Usage: unpxy [-p] [--] <command>
```

Passing an unknown option also results in an error:
```bash
unpxy -x echo hello
# unpxy: unknown option: -x
```

## How it works

* **Single command mode** (no `-p`):  
  Creates a subshell with `(...)`, unsets common proxy variables inside that subshell, and then replaces the subshell with your command via `exec "$@"`.  
  The parent shell’s proxy settings remain untouched.

* **Pipeline mode** (`-p`):  
  Also opens a subshell, unsets all proxy variables there, and then passes the quoted pipeline string to `eval`.  
  This allows complex shell syntax (pipes, redirects, command lists) to run entirely inside the proxy‑free environment.

After the command finishes, the subshell exits and your original shell environment is exactly as before.

## License

MIT — see [LICENSE](LICENSE) file.
