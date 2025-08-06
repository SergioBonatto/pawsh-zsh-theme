# =============================
# 🐾 Pawsh ZSH Theme
# =============================

autoload -U colors && colors
reset_color="%{$reset_color%}"

# Last command status
local prompt_status="%(?:%{${fg[green]}%}ᓚᘏᗢ%{${reset_color}%}:%{${fg[red]}%}ᓚᘏᗢ%{${reset_color}%})"

# Root user
local prompt_root="%(!.%{${fg[magenta]}%}#%{${reset_color}%}.)"

# Current directory
local prompt_dir="%{${fg[cyan]}%}%~%{${reset_color}%}"

# Virtualenv
function virtualenv_prompt {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    local venv_name="${VIRTUAL_ENV##*/}"
    echo "%{${fg_bold[blue]}%}[${venv_name}]%{${reset_color}%} "
  fi
}

# Vi mode (shows [N] if in normal mode)
function vi_mode_prompt {
  if [[ "$KEYMAP" == "vicmd" ]]; then
    echo "%{${fg_bold[red]}%}[N]%{${reset_color}%} "
  fi
}

# Git: prefix, suffix, dirty/clean status
ZSH_THEME_GIT_PROMPT_PREFIX="%{${fg_bold[blue]}%}git:(%{${fg[red]}%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{${reset_color}%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{${fg[blue]}%}) %{${fg[yellow]}%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{${fg[blue]}%})"

# Main prompt (all in one line)
PROMPT="${prompt_status} ${prompt_root}$(virtualenv_prompt)$(vi_mode_prompt)${prompt_dir} \$(git_prompt_info)"

function git_complete_status {
  if git rev-parse --git-dir > /dev/null 2>&1; then
    local branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
    local info="%{${fg[blue]}%}$branch%{${reset_color}%}"

    # Arquivos por categoria
    local modified=$(git diff --name-only 2>/dev/null | wc -l | tr -d ' ')
    local staged=$(git diff --cached --name-only 2>/dev/null | wc -l | tr -d ' ')
    local untracked=$(git ls-files --other --exclude-standard 2>/dev/null | wc -l | tr -d ' ')
    local deleted=$(git diff --name-only --diff-filter=D 2>/dev/null | wc -l | tr -d ' ')

    # Mostra contadores de arquivos
    if [[ "$staged" -gt 0 ]]; then
      info+=" %{${fg[green]}%}+$staged%{${reset_color}%}"
    fi
    if [[ "$modified" -gt 0 ]]; then
      info+=" %{${fg[yellow]}%}~$modified%{${reset_color}%}"
    fi
    if [[ "$deleted" -gt 0 ]]; then
      info+=" %{${fg[red]}%}-$deleted%{${reset_color}%}"
    fi
    if [[ "$untracked" -gt 0 ]]; then
      info+=" %{${fg[magenta]}%}?$untracked%{${reset_color}%}"
    fi

    # Commits ahead/behind
    local ahead behind
    ahead=$(git rev-list --count @{upstream}..HEAD 2>/dev/null)
    behind=$(git rev-list --count HEAD..@{upstream} 2>/dev/null)

    if [[ "$ahead" -gt 0 ]]; then
      info+=" %{${fg[cyan]}%}↑$ahead%{${reset_color}%}"
    fi
    if [[ "$behind" -gt 0 ]]; then
      info+=" %{${fg[red]}%}↓$behind%{${reset_color}%}"
    fi

    # Stashes
    local stashes=$(git stash list 2>/dev/null | wc -l | tr -d ' ')
    if [[ "$stashes" -gt 0 ]]; then
      info+=" %{${fg[white]}%}≡$stashes%{${reset_color}%}"
    fi

    # Conflitos (durante merge/rebase)
    local conflicts=$(git diff --name-only --diff-filter=U 2>/dev/null | wc -l | tr -d ' ')
    if [[ "$conflicts" -gt 0 ]]; then
      info+=" %{${fg_bold[red]}%}⚡$conflicts%{${reset_color}%}"
    fi

    # Estado especial (merge, rebase, cherry-pick, etc)
    local git_dir=$(git rev-parse --git-dir 2>/dev/null)
    if [[ -f "$git_dir/MERGE_HEAD" ]]; then
      info+=" %{${fg[yellow]}%}[MERGE]%{${reset_color}%}"
    elif [[ -d "$git_dir/rebase-merge" ]] || [[ -d "$git_dir/rebase-apply" ]]; then
      info+=" %{${fg[yellow]}%}[REBASE]%{${reset_color}%}"
    elif [[ -f "$git_dir/CHERRY_PICK_HEAD" ]]; then
      info+=" %{${fg[yellow]}%}[CHERRY]%{${reset_color}%}"
    elif [[ -f "$git_dir/BISECT_LOG" ]]; then
      info+=" %{${fg[yellow]}%}[BISECT]%{${reset_color}%}"
    fi

    echo "$info"
  fi
}
RPROMPT="\$(git_complete_status)"
# RPROMPT="%{${fg_bold[white]}%}%*%{${reset_color}%}"

# Update vi mode only if ZLE is active
function zle-reset-prompt {
  if [[ -n "$ZLE" ]]; then
    zle reset-prompt
  fi
}

# Hooks to update vi mode
autoload -Uz add-zsh-hook
if [[ -n "$ZLE" && ${(M)functions[zle-reset-prompt]} == function ]]; then
  add-zsh-hook zle-keymap-select zle-reset-prompt
fi
