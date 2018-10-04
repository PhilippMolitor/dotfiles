# First things first, colors!
cat ~/.cache/wal/sequences

# oh-my-zsh paths
export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$HOME/.config/zsh
export UPDATE_ZSH_DAYS=7

# oh-my-zsh basic settings
ZSH_THEME="lambda-mod"
DISABLE_LS_COLORS="false"
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"

# oh-my-zsh plugins
plugins=(
  colored-man-pages
  virtualenv
  zsh-completions
  zsh-autosuggestions
  zsh-syntax-hightlighting
)

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh


# enable completion to find new executables
zstyle ':completion:*' rehash true


# ENV: EDITOR / VISUAL
if [[ -n $SSH_CONNECTION ]]; then
  export TERM='xterm-256color'
fi

if [ -x "$(command -v nvim)" ]; then
  export VISUAL='nvim'
elif [ -x "$(command -v vim)" ]; then
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

# Aliases

# set correct $TERM for ssh connections
alias ssh="TERM=xterm-256color ssh"

# all the *vi* editors!
alias vi="$VISUAL"
alias vim="$VISUAL"

# redirect pacman to aurman
alias pacman="aurman"

# pretty mount table
alias mountfmt="mount | column -t | sort"

# python virtualenv
alias venv="virtualenv"
alias vact="source ./env/bin/activate"

# ls on steroids
unalias l 2>/dev/null
unalias ll 2>/dev/null
unalias la 2>/dev/null
unalias lsa 2>/dev/null

if [ -x "$(command -v exa)" ]; then
  alias ls="exa -h@ --git --group --group-directories-first --color always"
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
  pacman -Syyu
  pacman -Rncs $(pacman -Qtdq)
  sudo paccache -rk0
  aurman -Sc --noconfirm
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
  if [ $# -eq 0 ]; then
    echo -e "Invalid usage!"
    return 1
  fi;

  local tmp_file=$(mktemp -t transfer.sh.XXXXXX)
  local file_name=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g')

  curl --progress-bar --upload-file "$1" "https://transfer.sh/$file_name" >> $tmp_file

  cat $tmp_file
  rm -f $tmp_file
}

# run tmux
if [ -x "$(command -v tmux)" ]; then
  if [ -z "$TMUX" ]; then
    tmux; exit
  fi
fi

