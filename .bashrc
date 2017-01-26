# .bashrc
# 
# eirikref@gmail.com
# 2013-07-08


## Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

## PATH
export PATH="$PATH:/usr/local/mysql/bin:~/bin"

## Terminal
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    alias ls='ls -la --color=auto'
    export TERM=xterm-256color
elif [[ "$OSTYPE" == "darwin"* ]]; then
    alias ls='ls -la -G'
fi

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export LC_ALL="en_US.UTF-8"


## git specific
if [ -f ~/.git-completion.bash ]; then
    .  ~/.git-completion.bash
fi

function parseGitDirty
{
    [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working tree clean" ]] && echo "*"
}

function parseGitBranch
{
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/{\1$(parseGitDirty)}/"
}


#  Set prompt
function setPrompt
{
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

    case "$TERM" in
        "dumb")
            PS1="> "
            ;;
        xterm*|rxvt*|eterm*|screen*)
    PS1="${BRIGHT_VIOLET}[${VIOLET}\u@\h${WHITE}:\w\
${GREEN}\$(parseGitBranch)\
${BRIGHT_VIOLET}]${NORMAL}\$ ${RESET}"
    ;;
        *)
            PS1="> "
            ;;
    esac

    PS2='> '
    PS4='+ '
}
setPrompt


## SSH specific things
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

# Allow the user to set the title.
function title {
    PROMPT_COMMAND="echo -ne \"\033]0;$1\007\""
}

man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
            man "$@"
}

eval "$(direnv hook bash)"
HIST_TS="\033[0;36m"
HIST_NOCOLOR="\033[0m"
export HISTTIMEFORMAT=`echo -e ${HIST_TS}[%F %T] $HIST_NOCOLOR `
# export HISTTIMEFORMAT="%F ${VIOLET}%T "
