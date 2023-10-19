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

export PATH="/home/ihoronir/.local/bin:/home/ihoronir/.deno/bin:/home/ihoronir/.cargo/bin:$PATH"

#export PATH="/home/ihoronir/.cargo/bin:$PATH"
export LESSCHARSET=utf-8
export _JAVA_AWT_WM_NONREPARENTING=1

if [ -f ~/.ssh-agent ]; then
    . ~/.ssh-agent
fi
if [ -z "$SSH_AGENT_PID" ] || ! kill -0 $SSH_AGENT_PID; then
    ssh-agent > ~/.ssh-agent
    . ~/.ssh-agent
fi
ssh-add -l >& /dev/null || ssh-add


eval "$(starship init bash)"


alias peda='gdb -nx -ix=~/.gdbinit_peda'

export QSYS_ROOTDIR="/home/ihoronir/intelFPGA_lite/20.1/quartus/sopc_builder/bin"
