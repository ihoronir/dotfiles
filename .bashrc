#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

export EDITOR="nvim"
export QT_QPA_PLATFORMTHEME="qt5ct"
#export XDG_CURRENT_DESKTOP="Unity"

export PATH="/home/ihoronir/.deno/bin:$PATH"

