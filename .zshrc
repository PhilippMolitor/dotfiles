# First things first, colors!
cat ~/.cache/wal/sequences

# install zplug, if needed
if [[ ! -d "$HOME/.zplug" ]]; then
  git clone https://github.com/zplug/zplug "$HOME/.zplug/repos/zplug/zplug"
  ln -s "$HOME/.zplug/repos/zplug/zplug/init.zsh" "$HOME/.zplug/init.zsh"
  RUN_ZPLUG_INSTALL=1
fi

# load zplug plugin manager
source $HOME/.zplug/init.zsh

# plugins
zplug "zplug/zplug", hook-build:"zplug --self-manage"
zplug "zsh-users/zsh-completions"
zplug "zdharma/fast-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions", defer:2
zplug "hlissner/zsh-autopair", defer:2

zplug "philslab/abbr-zsh-theme", as:theme

# start zplug
if [[ -n $RUN_ZPLUG_INSTALL ]]; then
  zplug install
  unset RUN_ZPLUG_INSTALL
fi
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
bindkey "^I" expand-or-complete-prefix

# other zsh options
setopt GLOB_STAR_SHORT

# completion features
zstyle ':completion:*' rehash true
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

# add private bin path
PRIVATE_BIN_PATH="$HOME/.bin"

if [[ -n $PRIVATE_BIN_PATH  && -d $PRIVATE_BIN_PATH ]]; then
  export PATH="$PRIVATE_BIN_PATH:$PATH"
  unset PRIVATE_BIN_PATH
fi


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
alias fuck='sudo env "PATH=$PATH" $(fc -ln -1)'

# list all currently open sockets
alias lssockets='ss -nrlpt'

# pretty mount table
alias mountfmt="mount | column -t | sort"

# ls on steroids
if (( $+commands[exa] )) ; then
  alias ls="exa -h@ --git --group --group-directories-first --color always --color-scale"
  alias lt="ls -laT"
fi

alias ll="ls -l"
alias la="ls -la"

# set pywal background
alias background="wal --backend colorz -i"

# housekeeping (updates, cache cleanup, etc.)
housekeeping () {
  yay -Syyu --combinedupgrade --noconfirm
  pacman -Rncs $(pacman -Qtdq)
  sudo paccache -rk0
  yay -Scc --noconfirm
}

# upload to https://0x0.st
0x0 () {
  curl -sf -F "file=@$1" "https://0x0.st" || echo "error uploading $1"
}

# config management with git
dotconf () {
  local cdir="$HOME/.dotconf"

  [[ -d $cdir ]] || mkdir -p $cdir
  [[ -f $cdir/HEAD ]] || git init --bare $cdir

  git --git-dir=$cdir --work-tree=$HOME/ "$@"
}

