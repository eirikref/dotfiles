source ~/.profile
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

# After each command, append to the history file and reread it
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# export PATH="/usr/local/opt/mysql-client/bin:$PATH"
# export PATH="$PATH:/Applications/MAMP/Library/bin"
# alias php="/Applications/MAMP/bin/php/php7.4.12/bin/php"
# alias mysql="/Applications/MAMP/Library/bin/mysql"
. "$HOME/.cargo/env"
export PATH="/usr/local/opt/mariadb@10.5/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# MYSQL=/usr/local/mysql/bin
# export PATH=$PATH:$MYSQL
# export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH
export PATH="/usr/local/opt/mariadb@10.5/bin:$PATH"
