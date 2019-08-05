PROMPT_YES="Y"
PROMPT_NO="N"

yes_no_prompt () {
  read -p "$1" -n 1 -r input
  if [ "$input" != "N" ] && [ "$input" != "n" ] ; then
      echo "$PROMPT_YES"
  else
      echo "$PROMPT_NO"
  fi
}