### Soo-Hyun's .zshrc ###

# Environment
# setopt NOHUP
#setopt NOTIFY
#setopt NO_FLOW_CONTROL
setopt INC_APPEND_HISTORY #SHARE_HISTORY
setopt APPEND_HISTORY
# setopt AUTO_LIST		# these two should be turned off
# setopt AUTO_REMOVE_SLASH
# setopt AUTO_RESUME		# tries to resume command of same name
unsetopt BG_NICE		# do NOT nice bg commands
setopt CORRECT			# command CORRECTION
setopt EXTENDED_HISTORY		# puts timestamps in the history
# setopt HASH_CMDS		# turns on hashing
#
setopt MENUCOMPLETE
setopt ALL_EXPORT

# Set/unset  shell options
setopt   notify globdots correct pushdtohome cdablevars autolist
setopt   correctall autocd recexact longlistjobs
setopt   autoresume histignoredups pushdsilent 
setopt   autopushd pushdminus extendedglob rcquotes mailwarning
unsetopt bgnice autoparamslash

# Autoload zsh modules when they are referenced
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof


# Customize prompt
autoload colors zsh/terminfo
if [[ "$terminfo[colors]" -ge 8 ]]; then
    colors
fi
for color in BLACK RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
    eval PR_$color='%{$fg[${(L)color}]%}'
    eval PR_BRIGHT_$color='%{$fg_bold[${(L)color}]%}'
    (( count = $count + 1 ))
done
PR_RESET="%{${reset_color}%}"

PS1="$PR_BRIGHT_WHITE%n$PR_RESET$PR_BRIGHT_BLACK@$PR_RESET$PR_GREEN%m$PR_RESET:$PR_MAGENTA%~$PR_RESET $PR_BRIGHT_WHITE%(!.#.>)$PR_RESET "
RPS1="$PR_BRIGHT_BLACK%D{%m/%d %H:%M}$PR_RESET"

# Am I chrooted?
if [ $ISCHROOT ]; then
	PS1=$'\e[1;33m(chroot) \e[0m'$PS1
fi

#LANGUAGE=
LC_ALL='en_US.UTF-8'
LANG='en_US.UTF-8'
LC_CTYPE=C

unsetopt ALL_EXPORT


#################################### Aliases ##################################

# General commandline
alias ls='ls --color=auto --group-directories-first'
alias l='ls '
alias ll='ls -lh'
alias la='ls -a'
alias dfh='df -h'
alias sd='sudo shutdown -h'
alias sus='systemctl suspend'
alias so='xset dpms force off'
alias d='dmesg'
alias s='sensors'
alias y='yaourt'
alias svim='sudo vim'
alias m='ncmpcpp'
alias v='vim'
alias grep='grep --color=auto'
alias topcpu='ps aux | sort -nrk 3 | head'
alias z='zathura'
alias dm='xrandr --output DVI1 --mode'
alias fehh="feh --auto-zoom --geometry 900x600 -d"   # View images.
alias -g "backlight"="/bin/bash /usr/bin/asus-screen-brightness"

# Debian
alias sapt="sudo aptitude"
alias sapts="sudo aptitude search"
alias sapti="sudo aptitude install"
alias saptu="sudo aptitude update"
alias saptc="sudo aptitude clean"
alias saptd="sudo aptitude dist-upgrade"
alias debinst="sudo dpkg -i"

# SSH
alias keyon="ssh-add -t 10800"
alias keyoff="ssh-add -D"
alias keylist="ssh-add -l"
alias sshosu='ssh -t osu "screen -dR"'
alias sshengr='ssh -t engr "screen -dR"'
alias sshic='ssh -t ic "screen -dR"'
alias sshcvr='ssh -t cvr "screen -dR"'

# Tor
alias torbrowse='google-chrome --proxy-server="https=127.0.0.1:9050;socks=127.0.0.1:9050;sock4=127.0.0.1:9050;sock5=127.0.0.1:9050,ftp=127.0.0.1:9050" --incognito check.torproject.org'

# Arduino
alias ard="avrdude -c arduino -p m1280"

alias matlabc="matlab -nodesktop -nosplash -nojvm"


# Environment
setopt hist_ignore_dups
export BROWSER="google-chrome"
export EDITOR="vim"
export PACMAN="pacmatic"
export PATH="$PATH:/usr/local/bin:/usr/local/sbin/:/bin:/sbin:/usr/bin:/usr/sbin:$HOME/bin:$HOME/scripts:/opt/etherlab/bin:/opt/matlab/bin"
export C_INCLUDE_PATH="/usr/include:/usr/include/gtk-2.0:/usr/include/gtkextra-2.0:/usr/include/glib-2.0:/usr/lib/glib-2.0/include:/usr/include/cairo:/usr/include/giw:/usr/include/qwt"
export CPLUS_INCLUDE_PATH=$C_INCLUDE_PATH
export TZ="America/Los_Angeles"
export HISTFILE=$HOME/.zhistory
export HISTSIZE=32000
export SAVEHIST=32000
export HOSTNAME="`hostname`"
export PAGER='less'
export color=   # Fix Yaourt "initcolor: command not found" error

# Deal with "terminal not fully functional" warning when using urxvt
# case "$TERM" in
#     rxvt-256color)
#         TERM=rxvt-unicode
#         ;;
# esac


# ROS
source /opt/ros/desktop-full/setup.zsh
source /opt/ros/groovy/setup.zsh   # Put this line after sourcing desktop-full/setup.zsh
export ROS_WORKSPACE='/opt/ros/workspace'
export ROS_PACKAGE_PATH="$ROS_PACKAGE_PATH:$ROS_WORKSPACE:/opt/ros/groovy:/opt/ros/desktop-full:/home/yoos/devel/atrias:/home/yoos/devel/atrias/software/atrias_controllers:/opt/ros/starmac-ros-pkg:/home/yoos/devel/tricopter:/home/yoos/devel/omnikiwi:/home/yoos/devel/iarc_mission_6:/home/yoos/devel/school/engr421"
export ROS_PARALLEL_JOBS=-j3

# Orocos toolchain
. `rosstack find orocos_toolchain`/env.sh
export LUA_PATH=";;;`rosstack find orocos_toolchain`/ocl/lua/modules/?.lua"

# STM32F4 Discovery board
export CONFIG_STM32F4_DISCOVERY=1

export CHIBIOS=/home/yoos/devel/ChibiOS


# Initialize
autoload -U compinit
compinit
bindkey "[3~" delete-char
bindkey '[7~' beginning-of-line
bindkey '[8~' end-of-line
bindkey '[Z'  reverse-menu-complete   # Shift+Tab
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' menu select=1 _complete _ignored _approximate
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

# Completion Styles

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
    
# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists, the local web server details and host completion
# on processes completion complete all user processes
# zstyle ':completion:*:processes' command 'ps -au$USER'

## add colors to processes for kill completion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

#zstyle ':completion:*:processes' command 'ps ax -o pid,s,nice,stime,args | sed "/ps/d"'
zstyle ':completion:*:*:kill:*:processes' command 'ps --forest -A -o pid,user,cmd'
zstyle ':completion:*:processes-names' command 'ps axho command' 
#zstyle ':completion:*:urls' local 'www' '/var/www/htdocs' 'public_html'
#
#NEW completion:
# 1. All /etc/hosts hostnames are in autocomplete
# 2. If you have a comment in /etc/hosts like #%foobar.domain,
#    then foobar.domain will show up in autocomplete!
zstyle ':completion:*' hosts $(awk '/^[^#]/ {print $2 $3" "$4" "$5}' /etc/hosts | grep -v ip6- && grep "^#%" /etc/hosts | awk -F% '{print $2}') 
# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
    '*?.old' '*?.pro'
# the same for old style completion
#fignore=(.o .c~ .old .pro)

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm apache bin daemon games gdm halt ident junkbust lp mail mailnull \
        named news nfsnobody nobody nscd ntp operator pcap postgres radvd \
        rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs avahi-autoipd\
        avahi backup messagebus beagleindex debian-tor dhcp dnsmasq fetchmail\
        firebird gnats haldaemon hplip irc klog list man cupsys postfix\
        proxy syslog www-data mldonkey sys snort
# SSH Completion
zstyle ':completion:*:scp:*' tag-order \
   files users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:scp:*' group-order \
   files all-files users hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order \
   users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:ssh:*' group-order \
   hosts-domain hosts-host users hosts-ipaddr
zstyle '*' single-ignored show

