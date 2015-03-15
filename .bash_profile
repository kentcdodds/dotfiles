#enable the git bash completion commands
source ~/.git-completion

#PROMPT STUFF
GREEN=$(tput setaf 2);
YELLOW=$(tput setaf 3);
WHITE=$(tput setaf 7)

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
PS1="${YELLOW}\w${GREEN}\$(git_branch)${WHITE}\n$(rand_element 😅 👽 🔥 🚀 👻 ⛄ 👾 🍔 😄 🍰 🐑)  $ ";

# PATH ALTERATIONS
## Node
PATH="/usr/local/bin:$PATH";
## JDK
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)

# #Custom bins
PATH="$PATH:~/.bin";

## CDPATH ALTERATIONS
CDPATH=.:$HOME:$HOME/Developer/alianza:$HOME/Developer:$HOME/Desktop

# Custom Aliases
alias ll="ls -al";
alias ..="cd ../";
alias ..l="cd ../ && ll";
alias pg="echo 'Pinging Google' && ping www.google.com";
alias vb="vim ~/.bash_profile";
alias sb="source ~/.bash_profile";
alias de="cd ~/Desktop";
alias d="cd ~/Developer";
alias ss="cd ~/Developer/story-starter/";
cdl() { cd "$@" && ll; }

killport() { lsof -i tcp:"$@" | awk 'NR!=1 {print $2}' | xargs kill ;}

# gulp aliases
alias gw="gulp watch";
alias gt="gulp test";
alias gb="gulp build";
alias gj="gulp jade";
alias gwt="gulp watch:test";
alias gs="gulp server";
# npm aliases
alias nr="npm run";
alias nrs="nr start";
alias nrb="nr build";
alias nrt="nr test";
alias flush-npm="rm -rf node_modules && npm cache clear && npm i";
# Alianza aliases
alias a="cd ~/Developer/alianza/atac5/";

# Custom functions
mg () { mkdir "$@" && cd "$@" ; }

#nvm
source ~/.nvm/nvm.sh


# Because SourceTree's $PATH gets screwed up starting it normally...
alias st="open /Applications/SourceTree.app/Contents/MacOS/SourceTree";
alias adev="st &&  wstorm ~/Developer/alianza/atac5"

# use hub for git
alias git=hub

# Bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
. $(brew --prefix)/etc/bash_completion
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
