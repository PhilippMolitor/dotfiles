# First things first, colors!
cat ~/.cache/wal/sequences

# Path to your oh-my-zsh installation.
export ZSH=/home/phil/.oh-my-zsh
export UPDATE_ZSH_DAYS=7

ZSH_THEME="ban"

plugins=(
  git
  colored-man-pages
  colorize
  cp
  virtualenv
  arch
  sudo
  zsh-autosuggestions
)

DISABLE_LS_COLORS="false"
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
# HIST_STAMPS="mm/dd/yyyy"
# ZSH_CUSTOM=/path/to/new-custom-folder
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )
# CASE_SENSITIVE="true"
# HYPHEN_INSENSITIVE="true"
# DISABLE_AUTO_UPDATE="true"

source $ZSH/oh-my-zsh.sh


# ENV: EDITOR
if [[ -n $SSH_CONNECTION ]]; then
  export TERM='xterm-256color'
fi

if [ -x "$(command -v nvim)" ]; then
  export EDITOR='nvim'
  export VISUAL='nvim'
elif [ -x "$(command -v vim)" ]; then
  export EDITOR='vim'
  export VISUAL='vim'
else
  export EDITOR='vi'
  export VISUAL='vi'
fi

# ENV: SSH_KEY_PATH
export SSH_KEY_PATH="~/.ssh/rsa_id"

# ENV: BROWSER
export BROWSER="/usr/bin/opera"

# ENV: PAGER
export PAGER="most"
export MANPAGER="$PAGER"

# Aliases

# set correct $TERM for ssh connections
alias ssh="TERM=xterm-256color ssh"

# all the *vi* editors!
alias vi="$EDITOR"
alias vim="$EDITOR"

# redirect pacman to aurman
alias pacman="aurman"

# pretty mount table
alias mount="mount | column -t | sort"

# python virtualenv
alias venv="virtualenv"
alias vact="source ./env/bin/activate"

# ls on steroids
if [ -x "$(command -v ls_extended)" ]; then
  alias ls="ls_extended -sh"
fi

unalias ll 2>/dev/null
unalias la 2>/dev/null
alias ll="ls -la"

# set pywal background
alias background="wal -g --backend haishoku -i"

# config management with git
function dotconf {
  local cdir="$HOME/.cfg"

  [[ -d $cdir ]] || mkdir -p $cdir
  [[ -f $cdir/HEAD ]] || git init --bare $cdir

  git --git-dir=$cdir --work-tree=$HOME/ "$@" || echo -e "\n\nPlease specify a git action"
}

