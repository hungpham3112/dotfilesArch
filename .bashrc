[[ $- != *i* ]] && return

if [[ -f "$HOME/.local/share/blesh/ble.sh" ]]; then
    source "$HOME/.local/share/blesh/ble.sh" --noattach
fi

command -v fastfetch >/dev/null && fastfetch

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend checkwinsize

case "$TERM" in
    xterm-color|*-256color) color_prompt=yes ;;
esac

if [[ ${color_prompt:-} == yes ]]; then
    PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='\u@\h:\w\$ '
fi
unset color_prompt

case "$TERM" in
    xterm*|rxvt*) PS1="\[\e]0;\u@\h: \w\a\]$PS1" ;;
esac

if command -v dircolors >/dev/null; then
    [[ -r "$HOME/.dircolors" ]] && eval "$(dircolors -b "$HOME/.dircolors")" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -ahlF'
alias la='ls -A'
alias l='ls -CF'
alias vim='vi'
alias cls='clear'
alias md='mkdir'
alias alert='notify-send --urgency=low -i "$([[ $? = 0 ]] && printf terminal || printf error)" "$(history | tail -n1 | sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

mcd() {
    mkdir -p -- "$1" && cd -- "$1"
}

if [[ -f "$HOME/.bash_aliases" ]]; then
    source "$HOME/.bash_aliases"
fi

if ! shopt -oq posix; then
    if [[ -f /usr/share/bash-completion/bash_completion ]]; then
        source /usr/share/bash-completion/bash_completion
    elif [[ -f /etc/bash_completion ]]; then
        source /etc/bash_completion
    fi
fi

export PATH="$HOME/.local/bin:$HOME/.opencode/bin:$PATH"

if [[ -d "$HOME/.bun/bin" ]]; then
    export BUN_INSTALL="$HOME/.bun"
    export PATH="$BUN_INSTALL/bin:$PATH"
fi

if [[ -f "$HOME/.cargo/env" ]]; then
    source "$HOME/.cargo/env"
fi

if [[ -x "$HOME/miniforge3/bin/mamba" ]]; then
    export MAMBA_EXE="$HOME/miniforge3/bin/mamba"
    export MAMBA_ROOT_PREFIX="$HOME/miniforge3"
    __mamba_setup="$("$MAMBA_EXE" shell hook --shell bash --root-prefix "$MAMBA_ROOT_PREFIX" 2>/dev/null)"
    if [[ $? -eq 0 ]]; then
        eval "$__mamba_setup"
    else
        alias mamba="$MAMBA_EXE"
    fi
    unset __mamba_setup
fi

if [[ -x "$HOME/miniforge3/bin/conda" ]]; then
    __conda_setup="$("$HOME/miniforge3/bin/conda" shell.bash hook 2>/dev/null)"
    if [[ $? -eq 0 ]]; then
        eval "$__conda_setup"
    elif [[ -f "$HOME/miniforge3/etc/profile.d/conda.sh" ]]; then
        source "$HOME/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniforge3/bin:$PATH"
    fi
    unset __conda_setup

    if [[ -f "$HOME/miniforge3/etc/profile.d/mamba.sh" ]]; then
        source "$HOME/miniforge3/etc/profile.d/mamba.sh"
    fi
fi

if [[ -n ${CONDA_PREFIX:-} ]]; then
    export LD_LIBRARY_PATH="$CONDA_PREFIX/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
fi

if [[ -d "$HOME/.spicetify" ]]; then
    export PATH="$PATH:$HOME/.spicetify"
fi

if [[ -f "$HOME/.config/alacritty/alacritty.bash" ]]; then
    source "$HOME/.config/alacritty/alacritty.bash"
fi

export HEADROOM_PORT="8787"
export HEADROOM_HOST="127.0.0.1"
export HEADROOM_MODE="token"
export HEADROOM_BACKEND="anthropic"
export HEADROOM_TELEMETRY="off"

command -v uv >/dev/null && eval "$(uv generate-shell-completion bash)"
command -v uvx >/dev/null && eval "$(uvx --generate-shell-completion bash)"

if [[ -f "$HOME/.bashrc.local" ]]; then
    source "$HOME/.bashrc.local"
fi

[[ ${BLE_VERSION:-} ]] && ble-attach
