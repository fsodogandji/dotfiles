export ZSH=$HOME/.oh-my-zsh

#ZSH_THEME="robbyrussell"
ZSH_THEME="agnoster"

plugins=(git osx vagrant)

source $ZSH/oh-my-zsh.sh

# Check if GO is installed
command -v go >/dev/null 2>&1
GO_CHECK=$?

if [ $GO_CHECK -eq 0 ]; then
  export GOPATH=$HOME/go
  export PATH=$PATH:$HOME/go/bin
fi

#### MacOS OS Check ####

if [[ $(uname) == "Darwin" ]]; then
  # Check if pip is installed
  command -v pip >/dev/null 2>&1
  PIP_CHECK=$?

  # Check if pip2 is installed
  command -v pip2 >/dev/null 2>&1
  PIP2_CHECK=$?

  if [ $PIP_CHECK -eq 0 ]; then
    PIP_CMD=pip
  elif [ $PIP_CHECK -ne 0 ]; then
    if [ $PIP2_CHECK -eq 0 ]; then
      PIP_CMD=pip2
    fi
  fi

  # Lock the screen (when going AFK)
  # https://github.com/mathiasbynens/dotfiles/blob/master/.aliases#L157-L158
  alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

  # Recursively delete `.DS_Store` files
  alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

  # Flush Directory Service cache
  # https://github.com/mathiasbynens/dotfiles/blob/master/.aliases#L71-L72
  alias flush_dns="dscacheutil -flushcache && killall -HUP mDNSResponder"

  # Add color to folders/files
  alias ls='ls -G'

  # Get macOS Software Updates, and update installed Ruby gems, Homebrew, Python
  # modules, npm, and their installed packages.
  # Inspired by https://github.com/mathiasbynens/dotfiles/blob/master/.aliases#L56-L57
  alias update="sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; brew cask outdated | xargs brew cask reinstall; npm install npm -g; npm update -g; $PIP_CMD freeze | xargs $PIP_CMD install -U; sudo gem update --system; sudo gem update; sudo gem cleanup; sudo purge"

  if [ -f "/usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
    source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  fi

  if [ -f "/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
    source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  fi
fi

#### MacOS OS Check - END ####

# Set aliases
alias grep='grep --color=auto'
alias ll='ls -la'
alias lr='ls -latr'

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
