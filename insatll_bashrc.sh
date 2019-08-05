#!/bin/bash
SCRIPT_DIR="$(dirname "$0")"
COMMAND="[[ -f ~/.mybashrc ]] && . ~/.mybashrc"
BASHRC_PATH="$HOME/.bashrc"
MY_BASHRC_PATH="$HOME/.mybashrc"
REPO_BASHRC_PATH="$SCRIPT_DIR/.bashrc"
COMPUTER_COMMANDS_PATH="$HOME/.bash_commands"
REPO_COMMANDS_PATH="$SCRIPT_DIR/commands"
PROMPT_QUESTION="Are You Sure to replace old bash_commands with new? [Y/n] "

# IMPORT UTILS
. "$REPO_COMMANDS_PATH/utils.sh"

# if home .mybashrc does not exist copy repo .bashrc to home .mybashrc file
[[ -f ${MY_BASHRC_PATH} ]]  || cp "${REPO_BASHRC_PATH}" "${MY_BASHRC_PATH}"

# if home .mybashrc is different then repo .bashrc, copy repo bashrc to mybashrc
cmp --silent "${MY_BASHRC_PATH}" "${REPO_BASHRC_PATH}" || cp "${REPO_BASHRC_PATH}" "${MY_BASHRC_PATH}"

# if home .bashrc does not contains COMMAND append COMMAND to home .bashrc
grep -qxF "${COMMAND}" "${BASHRC_PATH}" || echo "${COMMAND}" >> "${BASHRC_PATH}"

# remove home .bash_commands folder
should_remove=$(yes_no_prompt "$PROMPT_QUESTION")
echo ""
if [ "$should_remove" == "$PROMPT_YES" ]; then
  # remove home .bash_commands folder
  rm -r "$COMPUTER_COMMANDS_PATH" 2>/dev/null
  # create commands dir
  mkdir -p "$COMPUTER_COMMANDS_PATH"
  # cp repo commands folder into computer commands folder
  cp "$REPO_COMMANDS_PATH"/* "$COMPUTER_COMMANDS_PATH"
fi

# restart bash to apply changes
exec bash
