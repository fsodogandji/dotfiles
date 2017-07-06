# .bashrc

#### SETUP TOOLS ####

# Instructions for setting up various tools

## LINUX ##
#
# cd $HOME
# git clone https://github.com/magicmonty/bash-git-prompt.git .bash-git-prompt --depth=1
#
## LINUX - END ##

## MacOS ##
#
# /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# brew install bash-completion
# brew install bash-git-prompt
#
## MacOS - END ##

#### SETUP TOOLS - END ####

#### NOTES ####
#
#### NOTES - END ####

#### BASH CONFIGURATION ####

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Set large history sizes
HISTSIZE=1000000
HISTFILESIZE=9000000

# Set aliases
alias grep='grep --color=auto'
alias ll='ls -la'
alias lr='ls -latr'

#### BASH CONFIGURATION - END ####

# Source global bashrc if it exists
if [ -f /etc/bashrc ]; then
  source /etc/bashrc
fi

# Check if GO is installed
command -v go >/dev/null 2>&1
GO_CHECK=$?

if [ $GO_CHECK -eq 0 ]; then
  export GOPATH=$HOME/go
  export PATH=$PATH:$HOME/go/bin
fi


#### LINUX OS Check ####

if [[ $(uname) == "Linux" ]]; then
  if [ -f $HOME/.bash-git-prompt/gitprompt.sh ]; then
    GIT_PROMPT_BIN_PATH=$HOME/.bash-git-prompt
  fi
  PATH=$PATH:$HOME/.local/bin:$HOME/bin
  export PATH
fi

#### LINUX OS Check - END ####

#### MacOS OS Check ####

if [[ $(uname) == "Darwin" ]]; then
  if [ -f "$(brew --prefix)/etc/bash_completion" ]; then
    source "$(brew --prefix)/etc/bash_completion"
  fi
  if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
    GIT_PROMPT_BIN_PATH="$(brew --prefix)/opt/bash-git-prompt/share"
  fi

  # Flush Directory Service cache
  alias flush_dns="dscacheutil -flushcache && killall -HUP mDNSResponder"

  # Recursively delete `.DS_Store` files
  alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

  # Lock the screen (when going AFK)
  alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

  # Add color to folders/files
  alias ls='ls -G'
fi

#### MacOS OS Check - END ####

#### Git Prompt Settings ####

if [[ $GIT_PROMPT_BIN_PATH ]]; then
  # GIT_PROMPT_END=...      # uncomment for custom prompt end sequence
  # GIT_PROMPT_FETCH_REMOTE_STATUS=0   # uncomment to avoid fetching remote status
  # GIT_PROMPT_SHOW_CHANGED_FILES_COUNT=0 # uncomment to avoid printing the number of changed files
  # GIT_PROMPT_SHOW_UNTRACKED_FILES=all # can be no, normal or all; determines counting of untracked files
  # GIT_PROMPT_SHOW_UPSTREAM=1 # uncomment to show upstream tracking branch
  # GIT_PROMPT_START=...    # uncomment for custom prompt start sequence
  # GIT_PROMPT_STATUS_COMMAND=gitstatus_pre-1.7.10.sh # uncomment to support Git older than 1.7.10
  # GIT_PROMPT_THEME_FILE=$HOME/.git-prompt-colors.sh
  GIT_PROMPT_ONLY_IN_REPO=1
  GIT_PROMPT_THEME="Minimal"

  __GIT_PROMPT_DIR=$GIT_PROMPT_BIN_PATH
  source $GIT_PROMPT_BIN_PATH/gitprompt.sh
fi

#### Git Prompt Settings - END ####

# Define colors for non git prompts
black="$(tput setaf 0)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"
magenta="$(tput setaf 5)"
cyan="$(tput setaf 6)"
white="$(tput setaf 7)"

reset="$(tput sgr0)"

# Custom prompt
export PS1="\u${white}@\h:${cyan}[\W]:${reset}\\$ "
