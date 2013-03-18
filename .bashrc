
# Check for an interactive session
[ -z "$PS1" ] && return

alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ ' #Default
PS1="\[\e[1;37m\]\u\[\e[0;37m\]@\[\e[0;32m\]\h \[\e[0;35m\]\w \[\e[0;36m\]$ \[\e[0;00m\]"

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
alias m="ncmpcpp"

# Kill berserking flash
alias flashkill="kill `ps aux | grep lib64flash | grep chrom | awk -F' ' '{print $2}'`"

# SSH
alias keyon="ssh-add -t 10800"
alias keyoff="ssh-add -D"
alias keylist="ssh-add -l"

alias stein="ssh -l csteinau -p 2222 steinauerauctions.com"
alias steinftp="ftp steinauerauctions.com"

# Arduino
alias ard="avrdude -c arduino -p m1280"

# Classical music radio KMFA
alias radio_kmfa="mplayer http://pubint.ic.llnwd.net/stream/pubint_kmfa"

# Environment
export BROWSER="google-chrome"
export EDITOR="vim"
export PACMAN="pacman-color"
export PATH="$PATH:$HOME/bin"
export C_INCLUDE_PATH="/usr/include:/usr/include/gtk-2.0:/usr/include/gtkextra-2.0:/usr/include/glib-2.0:/usr/lib/glib-2.0/include:/usr/include/cairo:/usr/include/giw:/usr/include/qwt"
export CPLUS_INCLUDE_PATH=$C_INCLUDE_PATH

# Deal with "terminal not fully functional" warning when using urxvt
# case "$TERM" in
#     rxvt-256color)
#         TERM=rxvt-unicode
#         ;;
# esac


shopt -s checkwinsize
fortune


# ROS
export ROS_ROOT=/home/yoos/devel/ros/ros
export PATH=$ROS_ROOT/bin:$PATH
export PYTHONPATH=$ROS_ROOT/core/roslib/src:$PYTHONPATH
if [ ! "$ROS_MASTER_URI" ] ; then export ROS_MASTER_URI=http://localhost:11311 ; fi
export ROS_PACKAGE_PATH=/home/yoos/devel/ros/stacks:/home/yoos/devel/drlsim:/home/yoos/devel/tricopter
source $ROS_ROOT/tools/rosbash/rosbash
export ROS_PARALLEL_JOBS=-j2
