## =============================
## 🐾 Pawsh ZSH Theme
## =============================

autoload -U colors && colors

## Last command status
local prompt_status="%(?:%F{#4ECDC4}ᓚᘏᗢ%f:%F{#EE4B4B}ᓚᘏᗢ%f)"

## Root user
local prompt_root="%(!.%{${fg[magenta]}%}#%{${reset_color}%}.)"

## Current directory
local prompt_dir='%{${fg[cyan]}%}$(if [[ $PWD == $HOME ]]; then echo "~"; else basename "$PWD"; fi)%{${reset_color}%}'

## Virtualenv
function virtualenv_prompt {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    local venv_name="${VIRTUAL_ENV##*/}"
    echo "%{${fg_bold[blue]}%}[${venv_name}]%{${reset_color}%} "
  fi
}

## Vi mode
function vi_mode_prompt {
  if [[ "$KEYMAP" == "vicmd" ]]; then
    echo "%{${fg_bold[red]}%}[N]%{${reset_color}%} "
  fi
}

## Git: prefix, suffix, dirty/clean (reimplementado sem OMZ)
ZSH_THEME_GIT_PROMPT_PREFIX="%{${fg_bold[blue]}%}git:(%{${fg[red]}%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{${reset_color}%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{${fg[blue]}%}) %{${fg[yellow]}%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{${fg[blue]}%})"

function git_prompt_info {
  git rev-parse --git-dir > /dev/null 2>&1 || return
  local branch
  branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
  local dirty
  if ! git diff --quiet 2>/dev/null || ! git diff --cached --quiet 2>/dev/null; then
    dirty="$ZSH_THEME_GIT_PROMPT_DIRTY"
  else
    dirty="$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
  echo "${ZSH_THEME_GIT_PROMPT_PREFIX}${branch}${dirty}${ZSH_THEME_GIT_PROMPT_SUFFIX}"
}

## Main prompt
PROMPT="${prompt_status} ${prompt_root}$(virtualenv_prompt)$(vi_mode_prompt)${prompt_dir} \$(git_prompt_info)"

function git_complete_status {
  git rev-parse --git-dir > /dev/null 2>&1 || return

  local branch
  branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
  local info="%{${fg[blue]}%}$branch%{${reset_color}%}"

  local modified staged untracked deleted
  modified=$(git diff --name-only 2>/dev/null | wc -l | tr -d ' ')
  staged=$(git diff --cached --name-only 2>/dev/null | wc -l | tr -d ' ')
  untracked=$(git ls-files --other --exclude-standard 2>/dev/null | wc -l | tr -d ' ')
  deleted=$(git diff --name-only --diff-filter=D 2>/dev/null | wc -l | tr -d ' ')

  [[ "$staged"    -gt 0 ]] && info+=" %{${fg[green]}%}+$staged%{${reset_color}%}"
  [[ "$modified"  -gt 0 ]] && info+=" %{${fg[yellow]}%}~$modified%{${reset_color}%}"
  [[ "$deleted"   -gt 0 ]] && info+=" %{${fg[red]}%}-$deleted%{${reset_color}%}"
  [[ "$untracked" -gt 0 ]] && info+=" %{${fg[magenta]}%}?$untracked%{${reset_color}%}"

  local ahead behind
  ahead=$(git rev-list --count @{upstream}..HEAD 2>/dev/null)
  behind=$(git rev-list --count HEAD..@{upstream} 2>/dev/null)

  [[ "$ahead"  -gt 0 ]] && info+=" %{${fg[cyan]}%}↑$ahead%{${reset_color}%}"
  [[ "$behind" -gt 0 ]] && info+=" %{${fg[red]}%}↓$behind%{${reset_color}%}"

  local stashes
  stashes=$(git stash list 2>/dev/null | wc -l | tr -d ' ')
  [[ "$stashes" -gt 0 ]] && info+=" %{${fg[white]}%}≡$stashes%{${reset_color}%}"

  local conflicts
  conflicts=$(git diff --name-only --diff-filter=U 2>/dev/null | wc -l | tr -d ' ')
  [[ "$conflicts" -gt 0 ]] && info+=" %{${fg_bold[red]}%}⚡$conflicts%{${reset_color}%}"

  local git_dir
  git_dir=$(git rev-parse --git-dir 2>/dev/null)
  [[ -f "$git_dir/MERGE_HEAD"                                  ]] && info+=" %{${fg[yellow]}%}[MERGE]%{${reset_color}%}"
  [[ -d "$git_dir/rebase-merge" || -d "$git_dir/rebase-apply" ]] && info+=" %{${fg[yellow]}%}[REBASE]%{${reset_color}%}"
  [[ -f "$git_dir/CHERRY_PICK_HEAD"                            ]] && info+=" %{${fg[yellow]}%}[CHERRY]%{${reset_color}%}"
  [[ -f "$git_dir/BISECT_LOG"                                  ]] && info+=" %{${fg[yellow]}%}[BISECT]%{${reset_color}%}"

  echo "$info"
}

RPROMPT="\$(git_complete_status)"

## Vi mode hooks
function zle-reset-prompt {
  if [[ -n "$ZLE" ]]; then
    zle reset-prompt
  fi
}

autoload -Uz add-zsh-hook
if [[ -n "$ZLE" && ${(M)functions[zle-reset-prompt]} == function ]]; then
  add-zsh-hook zle-keymap-select zle-reset-prompt
fi
