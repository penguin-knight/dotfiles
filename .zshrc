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

# tmux自動起動
[[ -z "$TMUX" && ! -z "$PS1" ]] && tmux

#ブランチ名を色付きで表示させるメソッド
function rprompt-git-current-branch {
  local branch_name st branch_status

  if [ ! -e  ".git" ]; then
    # gitで管理されていないディレクトリは何も返さない
    return
  fi
  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    # 全てcommitされてクリーンな状態
    branch_status="%F{green}"
  elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
    # gitに管理されていないファイルがある状態
    branch_status="%F{red}?"
  elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
    # git addされていないファイルがある状態
    branch_status="%F{red}+"
  elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
    # git commitされていないファイルがある状態
    branch_status="%F{yellow}!"
  elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
    # コンフリクトが起こった状態
    echo "%F{red}!(no branch)"
    return
  else
    # 上記以外の状態の場合は青色で表示させる
    branch_status="%F{blue}"
  fi
  # ブランチ名を色付きで表示する
  echo "${branch_status}[$branch_name]"
}

# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst

# プロンプトの右側(RPROMPT)にメソッドの結果を表示させる
RPROMPT='`rprompt-git-current-branch`'
