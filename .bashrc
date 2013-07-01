# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything:
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
#export HISTCONTROL=ignoredups

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" -a -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color)
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    ;;
*)
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    ;;
esac

# Comment in the above and uncomment this below for a color prompt
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
    ;;
*)
    ;;
esac

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profiles
# sources /etc/bash.bashrc).
#if [ -f /etc/bash_completion ]; then
#    . /etc/bash_completion
#fi

export LC_ALL="en_US.UTF-8"

function parse_git_dirty {
    [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]] && echo "*"
}
function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/{\1$(parse_git_dirty)}/"
}
function eirikref_prompt {
    eval `dircolors $HOME/.dir_colors`
    DULL=0
    BRIGHT=1

    FG_BLACK=30
    FG_RED=31
    FG_GREEN=32
    FG_YELLOW=33
    FG_BLUE=34
    FG_VIOLET=35
    FG_CYAN=36
    FG_WHITE=37

    FG_NULL=00

    BG_BLACK=40
    BG_RED=41
    BG_GREEN=42
    BG_YELLOW=43
    BG_BLUE=44
    BG_VIOLET=45
    BG_CYAN=46
    BG_WHITE=47

    BG_NULL=00

    ##
    # ANSI Escape Commands
    ##
    ESC="\033"
    NORMAL="\[$ESC[m\]"
    RESET="\[$ESC[${DULL};${FG_WHITE};${BG_NULL}m\]"
    ##
    # Shortcuts for Colored Text ( Bright and FG Only )
    ##

    # DULL TEXT
    BLACK="\[$ESC[${DULL};${FG_BLACK}m\]"
    RED="\[$ESC[${DULL};${FG_RED}m\]"
    GREEN="\[$ESC[${DULL};${FG_GREEN}m\]"
    YELLOW="\[$ESC[${DULL};${FG_YELLOW}m\]"
    BLUE="\[$ESC[${DULL};${FG_BLUE}m\]"
    VIOLET="\[$ESC[${DULL};${FG_VIOLET}m\]"
    CYAN="\[$ESC[${DULL};${FG_CYAN}m\]"
    WHITE="\[$ESC[${DULL};${FG_WHITE}m\]"

    # BRIGHT TEXT
    BRIGHT_BLACK="\[$ESC[${BRIGHT};${FG_BLACK}m\]"
    BRIGHT_RED="\[$ESC[${BRIGHT};${FG_RED}m\]"
    BRIGHT_GREEN="\[$ESC[${BRIGHT};${FG_GREEN}m\]"
    BRIGHT_YELLOW="\[$ESC[${BRIGHT};${FG_YELLOW}m\]"
    BRIGHT_BLUE="\[$ESC[${BRIGHT};${FG_BLUE}m\]"
    BRIGHT_VIOLET="\[$ESC[${BRIGHT};${FG_VIOLET}m\]"
    BRIGHT_CYAN="\[$ESC[${BRIGHT};${FG_CYAN}m\]"
    BRIGHT_WHITE="\[$ESC[${BRIGHT};${FG_WHITE}m\]"

    # REV TEXT as an example
    REV_CYAN="\[$ESC[${DULL};${BG_WHITE};${BG_CYAN}m\]"
    REV_RED="\[$ESC[${DULL};${FG_YELLOW}; ${BG_RED}m\]"

    PROMPT_COMMAND='export ERR=$?'

    PS1="${BRIGHT_VIOLET}[${VIOLET}\u@\h${WHITE}:\w\
${GREEN}\$(parse_git_branch)\
${BRIGHT_VIOLET}]${NORMAL}\$ ${RESET}"
    PS2='> '
    PS4='+ '

}
eirikref_prompt
alias screen='_ssh_auth_save ; export HOSTNAME=$(hostname) ; screen'


if [ -f /home/eirikref/.git-completion.bash ]; then
        . /home/eirikref/.git-completion.bash
fi


# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# Add bash completion for ssh: it tries to complete the host to which you 
# want to connect from the list of the ones contained in ~/.ssh/known_hosts

__ssh_known_hosts() {
    if [[ -f ~/.ssh/known_hosts ]]; then
        cut -d " " -f1 ~/.ssh/known_hosts | cut -d "," -f1
    fi
}

_ssh() {
    local cur known_hosts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    known_hosts="$(__ssh_known_hosts)"
    
    if [[ ! ${cur} == -* ]] ; then
        COMPREPLY=( $(compgen -W "${known_hosts}" -- ${cur}) )
        return 0
    fi
}

complete -o bashdefault -o default -o nospace -F _ssh ssh 2>/dev/null \
    || complete -o default -o nospace -F _ssh ssh
