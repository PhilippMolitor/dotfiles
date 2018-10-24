# First things first, colors!
cat ~/.cache/wal/sequences

# load zplug plugin manager
source $HOME/.zplug/init.zsh

# plugins
zplug "ael-code/zsh-colored-man-pages"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zdharma/fast-syntax-highlighting"

zplug "philslab/abbr-zsh-theme", as:theme

# start zplug
zplug load

# history settings
[ -z "$HISTFILE" ] && export HISTFILE=~/.zsh_history
export SAVEHIST=HISTSIZE=20000
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST

# key bindings
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[3~" delete-char
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# other zsh options
setopt DOTGLOB
setopt GLOB_STAR_SHORT

# completion features
zstyle ':completion:*' rehash true
zstyle ':completion:*:*:*:*:*' menu select
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

# upload to https://0x0.st
0x0 () {
  echo ">>  $(curl -s --fail -F "file=@$1" "https://0x0.st" || echo "error uploading $1")"
}

