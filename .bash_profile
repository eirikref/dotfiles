# .bash_profile
# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

eval "$(rbenv init -)"

# Maximum number of history lines in memory
export HISTSIZE=

# Maximum number of history lines on disk
export HISTFILESIZE=

# Ignore duplicate lines
export HISTCONTROL=ignoredups:erasedups

# Log time
export HISTTIMEFORMAT="%F %T "

# When the shell exits, append to the history file 
# instead of overwriting it
shopt -s histappend

# After each command, append to the history file 
#  and reread it
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
