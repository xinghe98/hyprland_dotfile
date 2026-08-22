# PATH 紧急修复：若继承的环境 PATH 已被截断（如缺 /usr/bin），先补齐系统路径
# 避免后续 fortune/cut/mkdir/uname 等基础命令报 not found
if [[ $PATH != *"/usr/bin"* ]]; then
  export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:$PATH"
fi
# 旧 PATH 修复同上：确保 PATH 包含基本系统目录

#fortune随机诗词 - 增加命令存在性检查，避免 PATH 异常时报错
if command -v fortune >/dev/null 2>&1; then
  fortune -e tang300 song100 >/tmp/zshinfo 2>/dev/null || echo "fortune 无可用诗词库" > /tmp/zshinfo
else
  : > /tmp/zshinfo
fi
echo "┏━━━━━━━━━━┳━━━━━━━━┓
┃ 类名     ┃ 大驼峰 ┃
┣━━━━━━━━━━╋━━━━━━━━┫
┃ 函数名   ┃ 大驼峰 ┃
┣━━━━━━━━━━╋━━━━━━━━┫
┃ 变量名   ┃ 小驼峰 ┃
┣━━━━━━━━━━╋━━━━━━━━┫
┃ 属性名   ┃ 大驼峰 ┃
┣━━━━━━━━━━╋━━━━━━━━┫
┃ 命名空间 ┃ 大驼峰 ┃
┗━━━━━━━━━━┻━━━━━━━━┛">>/tmp/zshinfo
if command -v lolcat >/dev/null 2>&1; then
  cat /tmp/zshinfo 2>/dev/null | lolcat 2>/dev/null || cat /tmp/zshinfo
else
  cat /tmp/zshinfo 2>/dev/null || true
fi

# 该zsh配置文件使用zinit进行插件管理

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# 修复emacs中不能输入中文
# LC_CTYPE="zh_CN.utf8"

#  移除重复的命令历史
setopt HIST_IGNORE_ALL_DUPS

# 取消zsh在输出不以换行符结尾的内容是在其后添加百分号并另其一行的特性
unsetopt prompt_cr prompt_sp

# 设置可以使用通配符
setopt nonomatch

# 免输入cd进入目录
setopt auto_cd

# 使用emacs的快捷键绑定
bindkey -v

# Go加速
export GO111MODULE=on
export GOPROXY=https://goproxy.cn,direct

# 加载zinit
if [[ ! -d ~/.zinit ]];then 
  git clone https://github.com/zdharma-continuum/zinit.git ~/.zinit/bin
fi
source ~/.zinit/bin/zinit.zsh

zinit ice blockf atpull'zinit creinstall -q .'
zinit light zsh-users/zsh-completions

autoload compinit
compinit

zinit light-mode for \
  hlissner/zsh-autopair \
  zdharma-continuum/fast-syntax-highlighting \
  MichaelAquilina/zsh-you-should-use \
  zsh-users/zsh-autosuggestions \
  Aloxaf/fzf-tab

zinit light zsh-users/zsh-history-substring-search

zinit light zdharma-continuum/history-search-multi-word

# FZF
zinit light junegunn/fzf-bin

# EXA
zinit light ogham/exa

# BAT
zinit light sharkdp/bat

# 快速目录跳转 (原重复的 fast-syntax-highlighting/autosuggestions/fzf-tab 已去重，保留 light-mode for 中的统一加载)
zinit ice lucid wait='1' # lucid ice 可以隐藏Turbo mode下插件加载完成的提示
zinit light skywind3000/z.lua

# 语法高亮/自动建议/fzf-tab 已在上面的 light-mode for 中加载，此处不再重复以避免重复报错
# 若需 Turbo 模式，可单独配置 lucid wait，此处保留最简去重版本
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'

# 加载 OMZ 框架及
zinit snippet OMZ::lib/completion.zsh
zinit snippet OMZ::lib/history.zsh

# 使用oh-my-zsh快捷键绑定
zinit snippet OMZ::lib/key-bindings.zsh

# 快速跳转
zinit snippet OMZ::plugins/z

# 彩色man文档
zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh

# 双击esc快速在命令前添加或删除sudo
zinit snippet OMZ::plugins/sudo/sudo.plugin.zsh

# vi模式
zinit snippet OMZ::plugins/vi-mode/vi-mode.plugin.zsh

# 解压
zinit snippet OMZ::plugins/extract

zinit ice lucid wait='1'
zinit snippet OMZ::plugins/git/git.plugin.zsh


# 加载主题
zinit ice depth=1
zinit light romkatv/powerlevel10k

source $ZDOTDIR/.zsh/fzf.zsh
source $ZDOTDIR/.zsh/aliases.zsh
source $ZDOTDIR/.zsh/keymaps.zsh

# 环境变量 — 修复原 142 行 `export PATH="/home/xinghe/.local/bin"` 丢失 $PATH 导致 /usr/bin 等系统路径被截断的严重 bug
# 同时去重、判空，避免无效路径污染 PATH
if [[ $PATH != *"/usr/bin"* ]]; then
  export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:$PATH"
fi
# bob/nvim-bin 原配置为 /home/lcg (笔误)，已修正为 xinghe；仅当目录存在时才加入 PATH
[[ -d "/home/xinghe/.local/share/bob/nvim-bin" ]] && export PATH="/home/xinghe/.local/share/bob/nvim-bin:$PATH"
[[ -d "/home/lcg/.local/share/bob/nvim-bin" ]] && export PATH="/home/lcg/.local/share/bob/nvim-bin:$PATH"
[[ -d "/home/xinghe/flutter-bin/flutter/bin" ]] && export PATH="/home/xinghe/flutter-bin/flutter/bin:$PATH"
export PATH="/home/xinghe/.local/bin:$PATH"
export dirs="~/MyTools/resources/dir.list"
export ANDROID_HOME=${HOME}/Android/Sdk
[[ -d "${ANDROID_HOME}/tools" ]] && export PATH="${ANDROID_HOME}/tools:${PATH}"
[[ -d "${ANDROID_HOME}/emulator" ]] && export PATH="${ANDROID_HOME}/emulator:${PATH}"
[[ -d "${ANDROID_HOME}/platform-tools" ]] && export PATH="${ANDROID_HOME}/platform-tools:${PATH}"
export EDITOR="nvim"
[[ -d "$HOME/go/bin" ]] && [[ $PATH != *"$HOME/go/bin"* ]] && export PATH="$PATH:$HOME/go/bin"
# 去重 PATH，保持唯一且有序 (zsh 特性)
typeset -U path PATH
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:~/.local/bin/:$PATH"
# if command -v pyenv 1>/dev/null 2>&1; then
#  eval "$(pyenv init -)"
# fi
# eval "$(pyenv virtualenv-init -)"

alias vi='nvim'
alias ya='yazi'
alias sudovim='sudoedit'
alias vizsh="vim \$ZDOTDIR/.zshrc"
alias vizshrc="vim \$ZDOTDIR/.zshrc"
alias vibash="vim $HOME/.bashrc"
alias e='extract'
alias cs='cowsay'
alias pacman='sudo pacman'
alias s='neofetch | lolcat'
alias n='neofetch'
alias cla='clear'
alias cls='clear'
alias ls='exa --icons -h'
alias lt='exa -aT --icons -h'
alias ll='exa -lag --icons -h'
alias lad='exa -laD --icons -h'
alias la='exa -a --icons -h'
alias	grep="grep --color=auto"
alias	diff="diff --color=auto"
alias ccat="highlight --out-format=ansi"
export POWERLEVEL9K_CONFIG_FILE="$HOME/.config/zsh/.p10k.zsh"
alias music='tmux new-session -s $$ "tmux source-file ~/.ncmpcpp/tsession"'
_trap_exit() { tmux kill-session -t $$; }
export MUSIC_DIR=/music

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
