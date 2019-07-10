#!/bin/bash
COMMAND="[[ -f ~/.mybashrc ]] && . ~/.mybashrc"
BASHRC_PATH="$HOME/.bashrc"
MY_BASHRC_PATH="$HOME/.mybashrc"

[[ -f ${MY_BASHRC_PATH} ]] || cp ".bashrc" ${MY_BASHRC_PATH}
grep -qxF "${COMMAND}" ${BASHRC_PATH} || echo "${COMMAND}" >> ${BASHRC_PATH}
source ${BASHRC_PATH}
