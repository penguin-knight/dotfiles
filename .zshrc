autoload -Uz colors
colors

HISTFILE=~/.zsh_history
export HISTSIZE=1000
export SAVEHIST=5000

PROMPT="%{${fg[red]}%}%n%{${reset_color}%} at %{${fg[blue]}%}%m%{${reset_color}%} in %{${fg[green]}%}%~%{${reset_color}%}
%F{yellow}>>%f "

autoload -Uz compinit
compinit
setopt auto_param_slash
setopt mark_dirs
setopt prompt_subst
setopt auto_menu
setopt auto_list
setopt auto_cd
setopt auto_pushd
setopt auto_param_keys
setopt interactive_comments
setopt magic_equal_subst
setopt complete_in_word

setopt no_tify
setopt hist_ignore_dups
setopt list_types
zstyle ':completion:*:processes' command "ps -u $USER"
setopt bang_hist
setopt extended_history
setopt hist_reduce_blanks

case ${OSTYPE} in
  darwin*)
    alias ls='ls -G'
    ;;
  linux*)
    alias ls='ls --color=auto'
    ;;
esac
alias sl='sl -e'
alias vi='vim'
