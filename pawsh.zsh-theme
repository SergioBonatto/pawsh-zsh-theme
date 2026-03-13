## =============================
## 🐾 Pawsh ZSH Theme (Optimized)
## =============================

ZSH_THEME_GIT_PROMPT_PREFIX="%{${fg_bold[blue]}%}git:(%{${fg[red]}%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{${reset_color}%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{${fg[yellow]}%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{${fg[blue]}%})"

function pawsh_git_info {

  git rev-parse --is-inside-work-tree &>/dev/null || return

  local git_status
  git_status=$(git status --porcelain=2 --branch 2>/dev/null)

  local branch ahead behind
  local staged=0 modified=0 deleted=0 untracked=0 conflicts=0

  while IFS= read -r line; do

    case "$line" in

      "# branch.head "*)
        branch=${line#"# branch.head "}
      ;;

      "# branch.ab "*)
        local ab=${line#"# branch.ab "}
        ahead=${ab#"+*"}
        ahead=${ahead%% -*}
        behind=${ab#*"-"}
      ;;

      "1 "*)
        local xy=${line:2:2}

        [[ ${xy:0:1} != "." ]] && ((staged++))
        [[ ${xy:1:1} != "." ]] && ((modified++))
      ;;

      "2 "*)
        local xy=${line:2:2}

        [[ ${xy:0:1} != "." ]] && ((staged++))
        [[ ${xy:1:1} != "." ]] && ((modified++))
      ;;

      "u "*)
        ((conflicts++))
      ;;

      "? "*)
        ((untracked++))
      ;;

    esac

  done <<< "$git_status"

  local info="%{${fg[blue]}%}$branch%{${reset_color}%}"

  [[ "$staged"    -gt 0 ]] && info+=" %{${fg[green]}%}+$staged%{${reset_color}%}"
  [[ "$modified"  -gt 0 ]] && info+=" %{${fg[yellow]}%}~$modified%{${reset_color}%}"
  [[ "$deleted"   -gt 0 ]] && info+=" %{${fg[red]}%}-$deleted%{${reset_color}%}"
  [[ "$untracked" -gt 0 ]] && info+=" %{${fg[magenta]}%}?$untracked%{${reset_color}%}"

  [[ "$ahead"  -gt 0 ]] && info+=" %{${fg[cyan]}%}↑$ahead%{${reset_color}%}"
  [[ "$behind" -gt 0 ]] && info+=" %{${fg[red]}%}↓$behind%{${reset_color}%}"

  [[ "$conflicts" -gt 0 ]] && info+=" %{${fg_bold[red]}%}⚡$conflicts%{${reset_color}%}"

  local stashes
  stashes=$(git stash list 2>/dev/null | wc -l | tr -d ' ')
  [[ "$stashes" -gt 0 ]] && info+=" %{${fg[white]}%}≡$stashes%{${reset_color}%}"

  local git_dir
  git_dir=$(git rev-parse --git-dir 2>/dev/null)

  [[ -f "$git_dir/MERGE_HEAD" ]] && info+=" %{${fg[yellow]}%}[MERGE]%{${reset_color}%}"
  [[ -d "$git_dir/rebase-merge" || -d "$git_dir/rebase-apply" ]] && info+=" %{${fg[yellow]}%}[REBASE]%{${reset_color}%}"
  [[ -f "$git_dir/CHERRY_PICK_HEAD" ]] && info+=" %{${fg[yellow]}%}[CHERRY]%{${reset_color}%}"
  [[ -f "$git_dir/BISECT_LOG" ]] && info+=" %{${fg[yellow]}%}[BISECT]%{${reset_color}%}"

  echo "$info"
}

function virtualenv_prompt {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    local venv_name="${VIRTUAL_ENV##*/}"
    echo "%{${fg_bold[blue]}%}[${venv_name}]%{${reset_color}%} "
  fi
}

function vi_mode_prompt {
  if [[ "$KEYMAP" == "vicmd" ]]; then
    echo "%{${fg_bold[red]}%}[N]%{${reset_color}%} "
  fi
}

PROMPT='%(?:%F{#4ECDC4}ᓚᘏᗢ%f:%F{#EE4B4B}ᓚᘏᗢ%f) %(!.%{${fg[magenta]}%}#%{${reset_color}%}.)$(virtualenv_prompt)$(vi_mode_prompt)%{${fg[cyan]}%}$(if [[ $PWD == $HOME ]]; then echo "~"; else ${PWD:t}; fi)%{${reset_color}%} $(pawsh_git_info)'

RPROMPT=''

function zle-keymap-select {
  zle reset-prompt
}

zle -N zle-keymap-select
