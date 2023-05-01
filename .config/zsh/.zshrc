setopt AUTO_CD

fpath=($ZDOTDIR/prompt_purification_setup $fpath)
source $ZDOTDIR/prompt_purification_setup

# completion system
autoload -Uz compinit; compinit
_comp_options+=(globdots) # hidden files
source $ZDOTDIR/completion.zsh

# directory stack
setopt AUTO_PUSHD         # push the current directory on the stack
setopt PUSHD_IGNORE_DUPS  # do not store duplicates in the stack
setopt PUSHD_SILENT       # do not print the directory stack after pushd or popd
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

# enable vi mode
bindkey -v
export KEYTIMEOUT=1

# change cursor
source $ZDOTDIR/plugins/cursor_mode

# hit v when in NORMAL mode to directly edit the command in specified editor
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# adding text objects
autoload -Uz select-bracketed select-quoted
zle -N select-quoted
zle -N select-bracketed
for km in viopp visual; do
  bindkey -M $km -- '-' vi-up-line-or-history
  for c in {a,i}${(s..)^:-\'\"\`\|,./:;=+@}; do
    bindkey -M $km $c select-quoted
  done
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $km $c select-bracketed
  done
done


# tim pope's surround plugin
autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
bindkey -M vicmd cs change-surround
bindkey -M vicmd ds delete-surround
bindkey -M vicmd ys add-surround
bindkey -M visual S add-surround

source /usr/share/nvm/init-nvm.sh

# prompt
# PROMPT="[%n@%m %~]$ "

# aliases
source $ZDOTDIR/aliases

# jumping to a parent directory easily
source $ZDOTDIR/plugins/bd.zsh

# syntax highlighting
# should be loaded last
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
