export TERM=xterm-256color

#PROMPT STUFF
GREEN=$(tput setaf 2);
YELLOW=$(tput setaf 3);
WHITE=$(tput setaf 7);
RESET=$(tput sgr0);

function git_branch {
  # Shows the current branch if in a git repository
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\ \(\1\)/';
}

rand() {
  printf $((  $1 *  RANDOM  / 32767   ))
}
rand_element () {
  local -a th=("$@")
  unset th[0]
  printf $'%s\n' "${th[$(($(rand "${#th[*]}")+1))]}"
}

#Default Prompt
setEmoji () {
  EMOJI="$@"
  PS1="${YELLOW}\w${GREEN}\$(git_branch)${RESET} ${EMOJI}\n$ ";
}

newRandomEmoji () {
  setEmoji $(rand_element 😅 👽 🔥 🚀 👻 ⛄ 👾 🍔 😄 🍰 🐑 😎 🏎 🤖 😇 😼 💪 🦄 🥓 🌮 🎉 💯 ⚛️ 🐠 🐳 🐿 🥳 🤩 🤯 🤠 👨‍💻 🦸‍♂️ 🧝‍♂️ 🧞‍♂️ 🧙‍♂️ 👨‍🚀 👨‍🔬 🕺 🦁 🐶 🐵 🐻 🦊 🐙 🦎 🦖 🦕 🦍 🦈 🐊 🦂 🐍 🐢 🐘 🐉 🦚 ✨ ☄️ ⚡️ 💥 💫 🧬 🔮 ⚗️ 🎊 🔭 ⚪️ 🔱)
}

newRandomEmoji

alias jestify="PS1=\"🃏  \"";
alias cypressify="PS1=\"🌀  \"";

# history size
HISTSIZE=5000
HISTFILESIZE=10000

# PATH ALTERATIONS
## Node
PATH="/usr/local/bin:$PATH:./node_modules/.bin";

# #Custom bins
PATH="$PATH:~/.bin";
# dotfile bins
PATH="$PATH:~/.my_bin";

## CDPATH ALTERATIONS
CDPATH=.:$HOME:$HOME/code:$HOME/Desktop

# Custom Aliases
alias a="atom .";
alias c="code .";
alias ll="ls -al";
alias ..="cd ../";
alias ..l="cd ../ && ll";
alias pg="echo 'Pinging Google' && ping www.google.com";
alias oc="open -a 'Google Chrome' $1";
alias vb="vim ~/.bash_profile";
alias sb="source ~/.bash_profile";
alias mvrc="mvim ~/dotfiles/.vimrc";
alias de="cd ~/Desktop";
alias d="cd ~/code";
shorten() { node ~/code/kcd.im/node_modules/.bin/netlify-shortener "$1" "$2"; }
cdl() { cd "$@" && ll; }
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
alias deleteDSFiles="find . -name '.DS_Store' -type f -delete"
alias kcd-oss="npx -p yo -p generator-kcd-oss -c 'yo kcd-oss'";
alias crapp="cp -R ~/.crapp $1";
alias npm-update="npx npm-check -u";
npm-latest() {
  npm info $1 | grep latest
}

alias lt="pushd ~/code/love-texts && serve || popd";

killport() { lsof -i tcp:"$@" | awk 'NR!=1 {print $2}' | xargs kill -9 ;}
alias flushdns="sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder"

# git aliases
alias gc="git commit -m $1";
alias gs="git status";
alias gp="git pull";
alias gf="git fetch";
alias gpush="git push";
alias gd="git diff";
alias ga="git add .";

# npm aliases
alias ni="npm install";
alias nrs="npm run start -s --";
alias nrb="npm run build -s --";
alias nrd="npm run dev -s --";
alias nrt="npm run test -s --";
alias nrtw="npm run test:watch -s --";
alias nrv="npm run validate -s --";
alias rmn="rm -rf node_modules;"
alias flush-npm="rm -rf node_modules && npm i && say NPM is done";
alias nicache="npm install --prefer-offline"
alias nioff="npm install --offline"
# yarn aliases
alias yar="yarn run";
alias yas="yarn run start -s --";
alias yab="yarn run build -s --";
alias yat="yarn run test -s --";
alias yoff="yarn add --offline";
alias ypm="echo \"Installing deps without lockfile and ignoring engines\" && yarn install --no-lockfile --ignore-engines"

# PayPal aliases
alias fixEtcHosts="sudo -- sh -c \"echo '127.0.0.1 localhost.paypal.com' >> /etc/hosts\""

# Custom functions
mg () { mkdir "$@" && cd "$@" ; }

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Because SourceTree's $PATH gets screwed up starting it normally...
alias st="open /Applications/SourceTree.app/Contents/MacOS/SourceTree";

# use hub for git
alias git=hub

# Bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
. $(brew --prefix)/etc/bash_completion
fi

# Got this from Jamis: https://gist.githubusercontent.com/jamischarles/752ad319df780122c772168ad0bbc67e/raw/aa4f14368ff4cbcc6f3f219167deac9b0c939ef1/.npm_install_autocomplete.bashrc

# BASH standalone npm install autocomplete. Add this to ~/.bashrc file.
_npm_install_completion () {
    local words cword
    if type _get_comp_words_by_ref &>/dev/null; then
      _get_comp_words_by_ref -n = -n @ -w words -i cword
    else
      cword="$COMP_CWORD"
      words=("${COMP_WORDS[@]}")
    fi

  local si="$IFS"

  # if your npm command includes `install` or `i `
  if [[ ${words[@]} =~ 'install' ]] || [[ ${words[@]} =~ 'i ' ]]; then
    local cur=${COMP_WORDS[COMP_CWORD]}

    # supply autocomplete words from `~/.npm`, with $cur being value of current expansion like 'expre'
    COMPREPLY=( $( compgen -W "$(ls ~/.npm )" -- $cur ) )
  fi

  IFS="$si"
}
# bind the above function to `npm` autocompletion
complete -o default -F _npm_install_completion npm
## END BASH npm install autocomplete

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).
