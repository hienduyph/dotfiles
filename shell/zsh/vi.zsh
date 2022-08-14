# Put cutbuffer after the cursor
function zvm_vi_put_after() {
  local head= foot=
  local content=$(pbpaste)
  local offset=1

  if [[ ${content: -1} == $'\n' ]]; then
    local pos=${CURSOR}

    # Find the end of current line
    for ((; $pos<$#BUFFER; pos++)); do
      if [[ ${BUFFER:$pos:1} == $'\n' ]]; then
        pos=$pos+1
        break
      fi
    done

    # Special handling if cursor at an empty line
    if zvm_is_empty_line; then
      head=${BUFFER:0:$pos}
      foot=${BUFFER:$pos}
    else
      head=${BUFFER:0:$pos}
      foot=${BUFFER:$pos}
      if [[ $pos == $#BUFFER ]]; then
        content=$'\n'${content:0:-1}
        pos=$pos+1
      fi
    fi

    offset=0
    BUFFER="${head}${content}${foot}"
    CURSOR=$pos
  else
    # Special handling if cursor at an empty line
    if zvm_is_empty_line; then
      head="${BUFFER:0:$((CURSOR-1))}"
      foot="${BUFFER:$CURSOR}"
    else
      head="${BUFFER:0:$CURSOR}"
      foot="${BUFFER:$((CURSOR+1))}"
    fi

    BUFFER="${head}${BUFFER:$CURSOR:1}${content}${foot}"
    CURSOR=$CURSOR+$#content
  fi

  # Reresh display and highlight buffer
  zvm_highlight clear
  zvm_highlight custom $(($#head+$offset)) $(($#head+$#content+$offset))
}

# Put cutbuffer before the cursor
function zvm_vi_put_before() {
  local head= foot=
  local content=$(pbpaste)

  if [[ ${content: -1} == $'\n' ]]; then
    local pos=$CURSOR

    # Find the beginning of current line
    for ((; $pos>0; pos--)); do
      if [[ "${BUFFER:$pos:1}" == $'\n' ]]; then
        pos=$pos+1
        break
      fi
    done

    # Check if it is an empty line
    if zvm_is_empty_line; then
      head=${BUFFER:0:$((pos-1))}
      foot=$'\n'${BUFFER:$pos}
      pos=$((pos-1))
    else
      head=${BUFFER:0:$pos}
      foot=${BUFFER:$pos}
    fi

    BUFFER="${head}${content}${foot}"
    CURSOR=$pos
  else
    head="${BUFFER:0:$CURSOR}"
    foot="${BUFFER:$((CURSOR+1))}"
    BUFFER="${head}${content}${BUFFER:$CURSOR:1}${foot}"
    CURSOR=$CURSOR+$#content
    CURSOR=$((CURSOR-1))
  fi

  # Reresh display and highlight buffer
  zvm_highlight clear
  zvm_highlight custom $#head $(($#head+$#content))
}

# workaroud for system clipboard
zvm_vi_yank () {
	zvm_yank
	printf %s "${CUTBUFFER}" | pbcopy
	zvm_exit_visual_mode
}
