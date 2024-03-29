# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

if [ "$color_prompt" = yes ]; then
    source ~/bin/completions/git-prompt.sh
    source ~/bin/completions/git-completion.bash
    export GIT_PS1_SHOWCOLORHINTS=1
    export GIT_PS1_DESCRIBE_STYLE="branch"
    get_sha() {
        git rev-parse --short HEAD 2>/dev/null
    }

    PROMPT_COMMAND=__prompt_command # Func to gen PS1 after CMDs

    __prompt_command() {
        local EXIT="$?"             # This needs to be first
        PS1=""

        local RCol='\[\e[0m\]'

        local Red='\[\e[0;31m\]'
        local Green='\[\e[0;32m\]'
        local Yel='\[\e[0;33m\]'
        local Blu='\[\e[0;34m\]'
        local Pur='\[\e[0;35m\]'
        local Grey='\[\e[0;37m\]'

        if [ $EXIT != 0 ]; then
            result="${Red}✗${RCol}"      # Add red if exit code non 0
        else
            result="${Green}✓${RCol}"
        fi
        __git_ps1 "${result} \[\e]0;\w\a\]${Blu}\u${RCol} " "\n${Yel}\w${RCol}$ " "(%s ${Grey}$(get_sha)${RCol})"
    }
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

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

# Set PKG path
PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/local/opt/libxml2/lib/pkgconfig

export EDITOR=vim

# Machine specific options
if [ -f ~/.bash_local ]; then
    . ~/.bash_local
fi

