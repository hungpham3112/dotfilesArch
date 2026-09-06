export PATH="$HOME/.local/bin:$PATH"

if [[ -d "$HOME/.bun/bin" ]]; then
    export BUN_INSTALL="$HOME/.bun"
    export PATH="$BUN_INSTALL/bin:$PATH"
fi

[[ -f "$HOME/.bashrc" ]] && source "$HOME/.bashrc"
