# First things first, colors!
cat ~/.cache/wal/sequences

# load antigen plugin manager
source $HOME/.antigen/antigen.zsh

# antigen plugins
antigen bundle ael-code/zsh-colored-man-pages
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zdharma/fast-syntax-highlighting

antigen theme philslab/abbr-zsh-theme

# apply changes (if any)
antigen apply

# history settings
[ -z "$HISTFILE" ] && export HISTFILE=~/.zsh_history
export SAVEHIST=HISTSIZE=20000
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST

# key bindings
bindkey "^[[3~" delete-char
bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward

# completion features
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' rehash true
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

# ssh settings
if [[ -n $SSH_CONNECTION ]]; then
  export TERM='xterm-256color'
fi

# ENV: EDITOR / VISUAL
if (( $+commands[nvim] )) ; then
  export VISUAL='nvim'
elif (( $+commands[vim] )) ; then
  export VISUAL='vim'
else
  export VISUAL='vi'
fi

export EDITOR="$VISUAL"

# ENV: SSH_KEY_PATH
export SSH_KEY_PATH="~/.ssh/rsa_id"

# ENV: BROWSER
export BROWSER="/usr/bin/firefox"

# ENV: PAGER
export PAGER="most"
export MANPAGER="$PAGER"

# all the *vi* editors!
alias vi="$VISUAL"
alias vim="$VISUAL"

# redirect pacman to yay
alias pacman="yay --noconfirm"

# in case someone (me) fucked up again...
alias fuck='sudo $(fc -ln -1)'

# list all currently open sockets
alias lssockets='ss -nrlpt'

# pretty mount table
alias mountfmt="mount | column -t | sort"

# python virtualenv
alias venv="virtualenv env && touch .venv"
alias vact="source ./env/bin/activate"

# ls on steroids
if (( $+commands[exa] )) ; then
  alias ls="exa -h@ --git --group --group-directories-first --color always --color-scale"
  alias lt="ls -laT"
fi

alias ll="ls -l"
alias la="ls -la"

# set pywal background
alias background="wal --backend colorz -i"

# monitor docker containers with watch
alias docker-watch='watch -ctd -n 1 docker ps --format \"table {{.Names}}\\t{{.Image}}\\t{{.Ports}}\\t{{.Status}}\"'

# housekeeping (updates, cache cleanup, etc.)
housekeeping () {
  yay -Syyu --combinedupgrade --noconfirm
  pacman -Rncs $(pacman -Qtdq)
  sudo paccache -rk0
  yay -Scc --noconfirm
}

# config management with git
dotconf () {
  local cdir="$HOME/.cfg"

  [[ -d $cdir ]] || mkdir -p $cdir
  [[ -f $cdir/HEAD ]] || git init --bare $cdir

  git --git-dir=$cdir --work-tree=$HOME/ "$@"
}

# upload to http://transfer.sh
transfer () {
  if [ $# -ne 1 ]; then
    echo -e "Usage: transfer <file>"
    return 1
  fi;

  local file_name=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g')
  curl --progress-bar --upload-file "$1" "https://transfer.sh/$file_name"
}

