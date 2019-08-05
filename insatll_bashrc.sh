#!/bin/bash
COMMAND="[[ -f ~/.mybashrc ]] && . ~/.mybashrc"
BASHRC_PATH="$HOME/.bashrc"
MY_BASHRC_PATH="$HOME/.mybashrc"
REPO_BASHRC_PATH=".bashrc"
COMPUTER_COMMANDS_PATH="$HOME/.bash_commands"
REPO_COMMANDS_PATH="./commands"
PROMPT_QUESTION="Are You Sure to replace old bash_commands with new? [Y/n] "
YES="Y"
NO="N"

yes_no_prompt () {
  read -p "$PROMPT_QUESTION" -n 1 -r input
  if [ "$input" != "N" ] && [ "$input" != "n" ] ; then
      echo "$YES"
  else
      echo "$NO"
  fi
}

# if home .mybashrc does not exist copyt repo .bashrc to home .mybashrc file
[[ -f ${MY_BASHRC_PATH} ]]  || cp ${REPO_BASHRC_PATH} ${MY_BASHRC_PATH}

# if home .mybashrc is different then repo .bashrc, copy repo bashrc to mybashrc
cmp --silent ${MY_BASHRC_PATH} ${REPO_BASHRC_PATH} || cp ${REPO_BASHRC_PATH} ${MY_BASHRC_PATH}

# if home .bashrc does not contains COMMAND append COMMAND to home .bashrc
grep -qxF "${COMMAND}" ${BASHRC_PATH} || echo "${COMMAND}" >> ${BASHRC_PATH}

# remove home .bash_commands folder
should_remove=$(yes_no_prompt)
echo ""
if [ "$should_remove" == "$YES" ]; then
  # remove home .bash_commands folder
  rm -r "$COMPUTER_COMMANDS_PATH" 2>/dev/null
  # create commands dir
  mkdir -p "$COMPUTER_COMMANDS_PATH"
  # cp repo commands folder into computer commands folder
  cp "$REPO_COMMANDS_PATH"/* "$COMPUTER_COMMANDS_PATH"
fi

# restart bash to apply changes
exec bash
