#!/bin/bash
COMMAND="[[ -f ~/.mybashrc ]] && . ~/.mybashrc"
BASHRC_PATH="$HOME/.bashrc"
MY_BASHRC_PATH="$HOME/.mybashrc"
REPO_BASHRC_PATH=".bashrc"

[[ -f ${MY_BASHRC_PATH} ]]  || cp ${REPO_BASHRC_PATH} ${MY_BASHRC_PATH}
cmp --silent ${MY_BASHRC_PATH} ${REPO_BASHRC_PATH} || cp ${REPO_BASHRC_PATH} ${MY_BASHRC_PATH}
grep -qxF "${COMMAND}" ${BASHRC_PATH} || echo "${COMMAND}" >> ${BASHRC_PATH}
exec bash
