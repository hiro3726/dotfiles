# ~/.zshrc
# $Id$

###
# General
###
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
umask 022
bindkey -e # emacs keybind
# fix some keybinds
bindkey "^?"    backward-delete-char # backspace
bindkey "^H"    backward-delete-char # backspace
bindkey "^[[3~" delete-char # del
bindkey "^[OH" beginning-of-line # home
bindkey "^[OF" end-of-line # end

###
# Environmental Values
###
export PYTHONSTARTUP=~/.pythonrc.py
export PATH=~/.bin:/usr/local/texlive/p2009/bin/x86_64-apple-darwin10.2.0:/usr/local/texlive/2009/bin/universal-darwin:/opt/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin:/opt/local/Library/Frameworks/Python.framework/Versions/2.6/bin

export CPPFLAGS="-I/opt/local/include -I/opt/local/Library/Frameworks/Python.framework/Versions/2.6/include/python2.6"
export LDFLAGS="-L/opt/local/lib"
export CFLAGS="-O3 -Wall $LDFLAGS"
export CXXFLAGS="$CFLAGS"

###
# Options
###
setopt  always_last_prompt      # 無駄なスクロールを避ける
setopt  append_history          # ヒストリファイルに追加
setopt  auto_list               # 自動的に候補一覧を表示
setopt  auto_menu               # 自動的にメニュー補完する
setopt  auto_name_dirs          # "~$var" でディレクトリにアクセス
setopt  auto_param_keys         # 変数名を補完する
setopt  auto_remove_slash       # 接尾辞を削除する
setopt  autocd					# ディレクトリ名でcdする
setopt	autopushd				# ディレクトリ履歴をプッシュ
setopt  bang_hist               # csh スタイルのヒストリ置換
setopt  brace_ccl               # {a-za-z} をブレース展開
setopt  cdable_vars             # 先頭に "~" を付けたもので展開
setopt  complete_in_word        # 語の途中でもカーソル位置で補完
setopt  complete_aliases        # 補完動作の解釈前にエイリアス展開
setopt  extended_glob           # "#", "~", "^" を正規表現として扱う
setopt  extended_history        # 開始/終了タイムスタンプを書き込み
#setopt hist_verify             # ヒストリ置換を実行前に表示
#setopt glob_dots               # "*" にドットファイルをマッチ
setopt  hist_ignore_dups        # 直前のヒストリと全く同じとき無視
setopt  hist_ignore_space       # 先頭がスペースで始まるとき無視
setopt  list_types              # ファイル種別を表す記号を末尾に表示
setopt	list_packed				# なるべくコンパクトにリストを表示
setopt  magic_equal_subst       # "val=expr" でファイル名展開
#setopt menu_complete           # 一覧表示せずに、すぐに最初の候補を補完
setopt  multios                 # 複数のリダイレクトやパイプに対応
setopt  numeric_glob_sort       # ファイル名を数値的にソート
setopt  noclobber               # リダイレクトで上書き禁止
setopt  no_beep                 # ベルを鳴らさない
#setopt no_check_jobs           # シェル終了時にジョブをチェックしない 
setopt  no_flow_control         # C-s/C-q によるフロー制御をしない
setopt  no_hup                  # 走行中のジョブにシグナルを送らない
setopt  no_list_beep            # 補完の時にベルを鳴らさない
setopt  notify                  # ジョブの状態をただちに知らせる
setopt  prompt_subst            # プロンプト内で変数展開
setopt  pushd_ignore_dups       # 重複するディレクトリを無視
setopt  rm_star_silent          # "rm * " を実行する前に確認
#setopt sun_keyboard_hack       # 行末の "` (バッククウォート)" を無視
setopt  sh_word_split           # 変数内の文字列分解のデリミタ
setopt  histallowclobber        # ">" を ">!" としてヒストリ保存
setopt  share_history           # share command history data

###
# Colors and Prompt
###
autoload -Uz colors
colors
PROMPT='%{%(?.$fg[green].$fg[red])%}%(!.#.%%)%{$reset_color%} '
RPROMPT='%{${fg[magenta]}%}%~%{${reset_color}%}'

###
# Aliases
###
alias a='./a.out'
alias ls='ls --color=auto' ll='ls -l' la='ls -a' dir='ls -la'
alias grep='grep --color'
alias less='/usr/share/vim/vim72/macros/less.sh'
alias pager='less -M'
alias c='clear'
alias gd='dirs -v; echo -n "select number: "; read newdir; cd +"$newdir"'
alias lsd='ls -d *(-/DN)' # list only directories
alias lsa='ls -d .*' # list only dot files
alias ipy='ipython'
alias u='euc2utf_filter'

alias clean='rm -rf *~; rm -rf *.bak; rm -rf a.out; rm -rf \#*'
alias cleandots='rm -rf .*~; rm -rf .*.bak'
alias reload='source ~/.zshrc'
alias C='LANG=C LC_ALL=C' J='LANG=ja_JP.UTF-8 LC_ALL=ja_JP.UTF-8'

alias -g G='| grep' L='| pager'

# some useful mpc aliases
alias p='mpc toggle'
alias s='mpc stop'
alias f='mpc next'
alias b='mpc prev'

alias setup='paster setup-app development.ini'
alias server='paster serve --reload development.ini'

###
# Completion
###
autoload -Uz compinit
compinit

###
# History Search
###
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end # C-p
bindkey "^N" history-beginning-search-forward-end # C-n

###
# Workaround for tramp
###
case "$TERM" in
  dumb | emacs)
    PROMPT="%m:%~> "
    unsetopt zle
    ;;
esac

###
# Misc
###
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} # color for completion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31' # color for kill

# EOF
