#!/bin/bash

export TERM=xterm-256color
export CLICOLOR=1
export LSCOLORS=Fafacxdxbxegedabagacad

# PROMPT STUFF
GREEN=$(tput setaf 2);
YELLOW=$(tput setaf 3);
RESET=$(tput sgr0);

function git_branch {
  # Shows the current branch if in a git repository
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\ \(\1\)/';
}

function random_element {
  declare -a array=("$@")
  r=$((RANDOM % ${#array[@]}))
  printf "%s\n" "${array[$r]}"
}

# Default Prompt
setEmoji () {
  EMOJI="$*"
  DISPLAY_DIR='$(dirs)'
  DISPLAY_BRANCH='$(git_branch)'
  PROMPT="${YELLOW}${DISPLAY_DIR}${GREEN}${DISPLAY_BRANCH}${RESET} ${EMOJI}"$'\n'"$ ";
}

newRandomEmoji () {
  setEmoji "$(random_element 😅 👽 🔥 🚀 👻 ⛄ 👾 🍔 😄 🍰 🐑 😎 🏎 🤖 😇 😼 💪 🦄 🥓 🌮 🎉 💯 ⚛️ 🐠 🐳 🐿 🥳 🤩 🤯 🤠 👨‍💻 🦸‍ 🧝‍ 🧞‍ 🧙‍ 👨‍🚀 👨‍🔬 🕺 🦁 🐶 🐵 🐻 🦊 🐙 🦎 🦖 🦕 🦍 🦈 🐊 🦂 🐍 🐢 🐘 🐉 🦚 ✨ ☄️ ⚡️ 💥 💫 🧬 🔮 ⚗️ 🎊 🔭 ⚪️ 🔱)"
}

newRandomEmoji

alias jestify="PS1=\"🃏\"$'\n'\"$ \"";
alias testinglibify="PS1=\"🐙\"$'\n'\"$ \"";
alias cypressify="PS1=\"🌀\"$'\n'\"$ \"";
alias staticify="PS1=\"🚀\"$'\n'\"$ \"";
alias nodeify="PS1=\"💥\"$'\n'\"$ \"";
alias reactify="PS1=\"⚛️\"$'\n'\"$ \"";
alias harryify="PS1=\"🧙‍\"$'\n'\"$ \"";

# allow substitution in PS1
setopt promptsubst

# history size
HISTSIZE=5000
HISTFILESIZE=10000

SAVEHIST=5000
setopt EXTENDED_HISTORY
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
# share history across multiple zsh sessions
setopt SHARE_HISTORY
# append to history
setopt APPEND_HISTORY
# adds commands as they are typed, not at shell exit
setopt INC_APPEND_HISTORY
# do not store duplications
setopt HIST_IGNORE_DUPS

# PATH ALTERATIONS
## Node
PATH="/usr/local/bin:$PATH:./node_modules/.bin";

# Custom bins
PATH="$PATH:$HOME/.bin";
# dotfile bins
PATH="$PATH:$HOME/.my_bin";

# CDPATH ALTERATIONS
CDPATH=.:$HOME:$HOME/code:$HOME/code/epic-react:$HOME/code/testingjavascript:$HOME/Desktop
# CDPATH=($HOME $HOME/code $HOME/Desktop)

# disable https://scarf.sh/
SCARF_ANALYTICS=false

# Custom Aliases
alias code="\"/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code\""
function c { code ${@:-.} }
alias ll="ls -1a";
alias ..="cd ../";
alias ..l="cd ../ && ll";
alias pg="echo 'Pinging Google' && ping www.google.com";
alias vz="vim ~/.zshrc";
alias cz="code ~/.zshrc";
alias sz="source ~/.zshrc";
alias de="cd ~/Desktop";
alias d="cd ~/code";
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
alias deleteDSFiles="find . -name '.DS_Store' -type f -delete"
alias kcd-oss="npx -p yo -p generator-kcd-oss -c 'yo kcd-oss'";
function crapp { cp -R ~/.crapp "$@"; }
function mcrapp { cp -R ~/.mcrapp "$@"; }
alias npm-update="npx ncu --dep prod --dep dev --upgrade";
alias flushdns="sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder"
alias dont_index_node_modules='find . -type d -name "node_modules" -exec touch "{}/.metadata_never_index" \;';

## git aliases
function gc { git commit -m "$@"; }
alias gs="git status";
alias gp="git pull";
alias gf="git fetch";
alias gpush="git push";
alias gd="git diff";
alias ga="git add .";
dif() { git diff --color --no-index "$1" "$2" | diff-so-fancy; }
cdiff() { code --diff "$1" "$2"; }

## npm aliases
alias ni="npm install";
alias nrs="npm run start -s --";
alias nrb="npm run build -s --";
alias nrd="npm run dev -s --";
alias nrt="npm run test -s --";
alias nrtw="npm run test:watch -s --";
alias nrv="npm run validate -s --";
alias rmn="rm -rf node_modules";
alias flush-npm="rm -rf node_modules package-lock.json && npm i && say NPM is done";
alias nicache="npm install --prefer-offline";
alias nioff="npm install --offline";

## use hub for git
alias git=hub

# Custom functions
mg () { mkdir "$@" && cd "$@" || exit; }
shorten() { node ~/code/kcd.im/node_modules/.bin/netlify-shortener "$1" "$2"; }
cdl() { cd "$@" && ll; }
npm-latest() { npm info "$1" | grep latest; }
killport() { lsof -i tcp:"$*" | awk 'NR!=1 {print $2}' | xargs kill -9 ;}
function quit () {
  if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: quit appname"
  else
    for appname in $1; do
    osascript -e 'quit app "'$appname'"'
    done
  fi
}

gif() {
  ffmpeg -i "$1" -vf "fps=25,scale=iw/2:ih/2:flags=lanczos,palettegen" -y "/tmp/palette.png"
  ffmpeg -i "$1" -i "/tmp/palette.png" -lavfi "fps=25,scale=iw/2:ih/2:flags=lanczos [x]; [x][1:v] paletteuse" -f image2pipe -vcodec ppm - | convert -delay 4 -layers Optimize -loop 0 - "${1%.*}.gif"
}

autoload -Uz compinit && compinit
# Bash completion
# TODO: couldn't get this to work with zsh...
# autoload bashcompinit
# bashcompinit
# if [ -f "$(brew --prefix)/etc/bash_completion" ]; then
# . "$(brew --prefix)/etc/bash_completion"
# fi

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).
