# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Get the aliases and functions
if [ -f ~/.bash_aliases ]; then
   . ~/.bash_aliases
fi

# Set the prompt to show the current git branch:
function parse_git_branch {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo " ("${ref#refs/heads/}")"
}

# Get the return code of the last command
function get_rc {
   RC=$?
   if [ "$RC" != "0" ]
   then
      echo " [$(tty -s && tput setaf 1)$RC$(tty -s && tput sgr0)]"
   fi
}

export PS1="\[$(tty -s && tput setaf 5)\]\u@\h\[$(tty -s && tput sgr0)\]\[$(tty -s && tput sgr0)\] [\t]\$(get_rc) \w\$(parse_git_branch) \\$ \[$(tty -s && tput     sgr0)\]"

export EDITOR=/usr/bin/vim

# Keep git repositories under home; include them on CDPATH
export CDPATH=${CDPATH}:${HOME}/git/

# Bash eternal history
export HISTTIMEFORMAT="%s "
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ; }"'echo $$ $USER \
                  "$(history 1)" >> ~/.bash_eternal_history'
function huh() {
   grep "${1}" ~/.bash_eternal_history
}

# PSQL
alias psql='env PAGER="less -S" psql'

# Try to fix command line issues
shopt -s checkwinsize
