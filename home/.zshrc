# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Which plugins would you like to load?
plugins=(git)

source $ZSH/oh-my-zsh.sh

# set PATH so it includes user's private bin if it exists
PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# Add GO to path
GOPATH="$HOME/go"
PATH="/usr/local/go/bin:$GOPATH:$GOPATH/bin:$PATH"

# Add Composer bins to path
PATH="$HOME/.config/composer/vendor/bin:$PATH"

# Add node modules bin to path
PATH="$HOME/node_modules/.bin:$PATH"

# Add chruby bin to path
PATH="/usr/local/share/chruby:$PATH"

# Add Brew to path
PATH="/opt/homebrew/bin:$PATH"

# Import aliases
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# Use vim by default
export EDITOR=vim

# Spin autocomplete
if command -v spin &> /dev/null
then
  zstyle ':completion:*' use-cache on
  autoload -Uz compinit && compinit
  source <(spin completion)
fi

[[ -f /opt/dev/sh/chruby/chruby.sh ]] && type chruby >/dev/null 2>&1 || chruby () { source /opt/dev/sh/chruby/chruby.sh; chruby "$@"; }

[[ -x /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv)

[ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh

[[ -f /etc/spin/secrets/buildkite ]] && export BUILDKITE_TOKEN="$(cat /etc/spin/secrets/buildkite)"

