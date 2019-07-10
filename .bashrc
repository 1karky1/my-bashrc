# coloured ls command
alias ls='ls --color=auto'

# coloured grep command
alias grep='grep --color=auto'

# Make vim default editor if installed
if type vim >/dev/null 2>/dev/null; then
    export EDITOR=vim
else
    echo "vim not installed."
fi

# brew completion
if type brew >/dev/null 2>/dev/null; then
    if [[ -f $(brew --prefix)/etc/bash_completion ]]; then
      . $(brew --prefix)/etc/bash_completion
    else
        echo "brew bash completion script is missing"
    fi
else
    echo "brew not installed."
fi

# git completion
LINK_TO_GIT_COMPLETION_SCRIPT="https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash"
GIT_COMPLETION_PATH="$HOME/.git-completion.bash"
if type git >/dev/null 2>/dev/null; then
    if [[ -f ${GIT_COMPLETION_PATH} ]]; then
        . ${GIT_COMPLETION_PATH}
    else
        if type wget >/dev/null 2>/dev/null; then
            wget ${LINK_TO_GIT_COMPLETION_SCRIPT} -O ${GIT_COMPLETION_PATH}
            . ${GIT_COMPLETION_PATH}
        else
            echo "wget not installed."
        fi
    fi
else
    echo "git not installed."
fi

# npm completion
NPM_COMPLETION_PATH="$HOME/.npm-completion.bash"
if type npm >/dev/null 2>/dev/null; then
    if [[ -f ${NPM_COMPLETION_PATH} ]]; then
        . ${NPM_COMPLETION_PATH}
    else
        npm completion >> ${NPM_COMPLETION_PATH}
        . ${NPM_COMPLETION_PATH}
    fi
else
    echo "npm not installed."
fi

# sudo completion
if type sudo >/dev/null 2>/dev/null; then
    if [ "$PS1" ]; then
        complete -cf sudo
    fi
else
    echo "sudo not installed"
fi

# PS1
START_NON_PRINTING_SEQUENCE="\["
END_NON_PRINTING_SEQUENCE="\]"
START_COLOR_SEQUENCE="\e["
END_COLOR_SEQUENCE="\e[m"
USERNAME="\u"
WORKING_DIRECTORY="\w"

# PS1 colors
GREEN="0;32m"
RED="0;31m"
BBLUE="1;34m"
BLGREY="1;37m"

#PS1 functions
start_color() {
    color=$1
    echo "${START_NON_PRINTING_SEQUENCE}${START_COLOR_SEQUENCE}${color}${END_NON_PRINTING_SEQUENCE}"
}
end_color() {
    echo "${START_NON_PRINTING_SEQUENCE}${END_COLOR_SEQUENCE}${END_NON_PRINTING_SEQUENCE}"
}
git_branch() {
	if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) != "true" ]]; then
		echo "";
	else
		branch_name=$(parse_git_branch)
		if git status 2>/dev/null | grep --quiet "nothing to commit"; then
			echo  "$(ps1_string ${GREEN} "(✓ ${branch_name})")";
		else
			echo  "$(ps1_string ${RED} "(☢ ${branch_name})")";
		fi;
	fi;
}
parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}
ps1_string(){
    color="$1"
    content="$2"
    echo "$(start_color ${color})${content}$(end_color)"
}
ps1_git() {
    echo "$(git_branch)"
}
ps1_username() {
    echo "$(ps1_string ${GREEN} ${USERNAME})"
}
ps1_working_directory() {
    echo "$(ps1_string ${BBLUE} ${WORKING_DIRECTORY})"
}
ps1_start_sign() {
    echo "$(ps1_string ${GREEN} "$")"
}

PS1="$(ps1_username) $(ps1_working_directory) $(ps1_git) \n$(ps1_start_sign) $(start_color ${BLGREY})"






