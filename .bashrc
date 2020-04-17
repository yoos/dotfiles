
# Check for an interactive session
[ -z "$PS1" ] && return

alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ ' #Default
PS1="\[\e[1;37m\]\u\[\e[0;37m\]@\[\e[0;32m\]\h \[\e[0;35m\]\w \[\e[0;36m\]$ \[\e[0;00m\]"

# Am I chrooted?
if [ $ISCHROOT ]; then
	PS1='\[\e[1;33m\](chroot)\[\e[0m\]'$PS1
fi

# Debian
alias sapt="sudo aptitude"
alias sapts="sudo aptitude search"
alias sapti="sudo aptitude install"
alias saptu="sudo aptitude update"
alias saptc="sudo aptitude clean"
alias saptd="sudo aptitude dist-upgrade"
alias debinst="sudo dpkg -i"

# General command line
alias l="ls -CF --group-directories-first"
alias ll="l -lh"
alias la="l -a"
alias dfh="df -h"
alias sd="sudo shutdown -h "
alias s="sensors"
alias y="yaourt"
alias svim="sudo vim"

# SSH
alias keyon="ssh-add -t 10800"
alias keyoff="ssh-add -D"
alias keylist="ssh-add -l"

# Environment
export BROWSER="google-chrome"
export EDITOR="vim"
export PACMAN="pacman-color"
export PATH="$PATH:$HOME/bin"

# Deal with "terminal not fully functional" warning when using urxvt
# case "$TERM" in
#     rxvt-256color)
#         TERM=rxvt-unicode
#         ;;
# esac


shopt -s checkwinsize
