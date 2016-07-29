export TERM=xterm-256color

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
# PS1="${YELLOW}\w${GREEN}\$(git_branch)${WHITE}\n$ ";

# PATH ALTERATIONS
## Node
PATH="/usr/local/bin:$PATH";

# #Custom bins
PATH="$PATH:~/.bin";
# dotfile bins
PATH="$PATH:~/.my_bin";

## CDPATH ALTERATIONS
CDPATH=.:$HOME:$HOME/Developer:$HOME/Desktop

# Custom Aliases
alias a="atom .";
alias ll="ls -al";
alias ..="cd ../";
alias ..l="cd ../ && ll";
alias pg="echo 'Pinging Google' && ping www.google.com";
alias oc="open -a 'Google Chrome' $1";
alias vb="vim ~/.bash_profile";
alias sb="source ~/.bash_profile";
alias mvrc="mvim ~/dotfiles/.vimrc";
alias de="cd ~/Desktop";
alias d="cd ~/Developer";
alias diary='pushd ~/Google\ Drive/Personal/Documents/Records/developer-diary && mvim `date +"%Y-%m-%d"`.md && popd'
cdl() { cd "$@" && ll; }
shorten() {
  ~/Developer/hive-api/dist/cli.js --url "$1" --custom "$2";
}

alias lt="http-server ~/Developer/love-texts";

killport() { lsof -i tcp:"$@" | awk 'NR!=1 {print $2}' | xargs kill ;}

# git aliases
alias gc="git commit -m $1";
alias gs="git status";
alias gp="git pull";
alias gf="git fetch";
alias gpush="git push";
alias gd="git diff";
alias ga="git add .";

# javascript air
JSA_DIR="~/Developer/javascriptair/site"
alias jsa="cd $JSA_DIR"

# npm aliases
alias ni="npm install";
alias nrs="npm run start -s --";
alias nrb="npm run build -s --";
alias nrt="npm run test -s --";
alias rmn="rm -rf node_modules;"
alias flush-npm="rm -rf node_modules && npm i && say NPM is done";
alias nicache="npm install --cache-min 999999"

# PayPal aliases
alias p="cd ~/Developer/paypal/p2pnodeweb";
alias np="p && NODE_ENV=test node ."
alias fixEtcHosts="sudo -- sh -c \"echo '127.0.0.1 localhost.paypal.com' >> /etc/hosts\""

# Custom functions
mg () { mkdir "$@" && cd "$@" ; }

# VSCode
function code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $*; }



# Because SourceTree's $PATH gets screwed up starting it normally...
alias st="open /Applications/SourceTree.app/Contents/MacOS/SourceTree";

# use hub for git
alias git=hub

# Bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
. $(brew --prefix)/etc/bash_completion
fi

export PATH="$PATH:$HOME/.rvm/bin"


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


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

# nvm
source ~/.nvm/nvm.sh
source ~/.avn/bin/avn.sh
