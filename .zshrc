# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="af-magic"
ZSH_THEME=powerlevel10k/powerlevel10k	

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="mm/dd/yyyy"
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  dotenv
  autojump
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="$EDITOR ~/.zshrc"
alias ohmyzsh="$EDITOR ~/.oh-my-zsh"
alias wget='wget --trust-server-names' #--no-check-certificate'

alias rg="rg --hidden --glob '!.git'"
alias grep='grep --color=always'
alias less='less -R'
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
alias adb='docker run --rm -ti --net host sorccu/adb adb'
alias bs="numfmt --to=iec --suffix=B"
alias bsi="numfmt --to=iec-i --suffix=B"
alias iec="numfmt --from=iec --suffix=B"
alias iec-i="numfmt --from=iec-i --suffix=B"

# utilities
# https://github.com/sharkdp/bat
alias cat='batcat --style=plain'

# https://sw.kovidgoyal.net/kitty/faq/
# ignore: prefer ssh config:
# Host *
#  SetEnv TERM=xterm-256color
# if [[ "$TERM" == "xterm-kitty"* ]]; then
# alias ssh="kitty +kitten ssh"
# fi

# https://stackoverflow.com/questions/394230/how-to-detect-the-os-from-a-bash-script?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
if [[ "$OSTYPE" == "darwin"* ]]; then
	# requires coreutils on mac
	alias ls='LC_COLLATE=C gls -lFha -G --group-directories-first --color '
else
	alias ls='LC_COLLATE=C ls -lFha -G --group-directories-first --color '
fi

# git
function makepr() {
  giturl='github.com'
  branch=`git rev-parse --abbrev-ref HEAD`
  remote=`git remote get-url origin`
  if [[ $remote == https* ]]; then  
    project=$(echo $remote | sed -e "s/.*$giturl\/\(.*\).git.*/\1/")
  else
    project=$(echo $remote | sed 's%^.*:\([^:]*\)\.git$%\1%g')
  fi
  xdg-open "https://$giturl/$project/compare/$branch?expand=1"
}

GIT_COMMAND=$(which git)
alias dotfiles="$GIT_COMMAND --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

# git aliases
setupGitAliases() {
  git config --global alias.lg   "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
  git config --global alias.st   "status"
  git config --global alias.pl   "pull"
  git config --global alias.p    "push"
  git config --global alias.c    "commit -v"
  git config --global alias.ca   "commit -v -a"
  git config --global alias.b    "branch"
  git config --global alias.co   "checkout"
  git config --global alias.cob  "checkout -b"
  git config --global alias.log  "log"
  git config --global alias.d    "diff --color --ignore-space-at-eol -b -w --ignore-blank-lines"
  git config --global alias.dd   "diff --color-words --word-diff-regex='[A-z0-9_]+|[^[:space:]]' --ignore-blank-lines"
  git config --global alias.dw   "diff -w --word-diff=color --word-diff-regex=."
  git config --global alias.stap "stash && git stash apply"
  git config --global alias.sc   "diff --name-only --diff-filter=U"
  git config --global core.editor "code --wait"
}


# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Less colors
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;38;5;74m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[30;43m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[04;38;5;146m'

# Emacs
if [[ "$OSTYPE" == "darwin"* ]]; then
	# > brew install emacs
	# > ln -s /usr/local/Cellar/emacs/25.3/Emacs.app /Applications
	export PATH="/usr/local/Cellar/emacs/25.3/bin/:$PATH"
fi
export ALTERNATE_EDITOR=""
#export EDITOR="emacsclient"                     # $EDITOR should open in terminal
#export VISUAL="emacsclient -c -a emacs"         # $VISUAL opens in GUI with non-daemon as alternate

# use vscode for now
export EDITOR="code"
export VISUAL="code"

alias demax="emacs --daemon"
alias wemax="emacsclient -c"
alias nemax="emacsclient -c -nw"
alias emax="emacsclient -t"                      # used to be "emacs -nw"
alias emaxg="emacsclient -c -a emacs"            # new - opens the GUI with alternate non-daemon
alias semax="sudo emacsclient -t"                # used to be "sudo emacs -nw"
alias femacs='emacs $(fzf)'


# https://stackoverflow.com/questions/367442/getting-emacs-ansi-term-and-zsh-to-play-nicely
if [ -n "$INSIDE_EMACS" ]; then
  chpwd() { print -P "\033AnSiTc %d" }
  print -P "\033AnSiTu %n"
  print -P "\033AnSiTc %d"
fi

alias pgstart="sudo systemctl start postgresql@11-main"
alias pgstop="sudo systemctl stop postgresql@11-main"

# Maven
# dont use asdf shim so we can override JAVA_HOME for Loom
export M2_HOME="/home/mping/Devel/apache-maven-3.8.1"
export PATH="$M2_HOME/bin:$PATH"


# Cargo ASDF
if [[ -d "/home/mping/.asdf/installs/rust/stable/bin" ]]; then
	export PATH="$PATH:/home/mping/.asdf/installs/rust/stable/bin"
fi


# asdf
if [[ -s "$HOME/.asdf/asdf.sh" ]]; then
	source "$HOME/.asdf/asdf.sh"
	source "$HOME/.asdf/completions/asdf.bash"

	asdf_update_java_home() {
	  local current
	  if current=$(asdf current java); then
	    local version=$(echo $current | cut -d '(' -f 1) 
	    export JAVA_HOME=$(asdf where java) # $version
	    echo "JAVA_HOME: $JAVA_HOME"
	  else
	    echo "No java version set. Type `asdf list-all java` for all versions."
	  fi
	}
fi

# Export path with ~/.local/bin
export PATH=$PATH:~/.local/bin
export PATH=$PATH:~/bin


# Fzf fuzzy search stuff
if [[ -s "$HOME/.fzf.zsh" ]]; then
  export FZF_DEFAULT_OPTS='--extended'
	[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
	[ -f ~/.fzf-functions.zsh ] && source ~/.fzf-functions.zsh
  
fi


if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
    source /etc/profile.d/vte.sh
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# local zsh
[[ ! -f ~/.zshlocal ]] || source ~/.zshlocal
