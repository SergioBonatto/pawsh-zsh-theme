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

# Time on the right corner
RPROMPT="%{${fg_bold[white]}%}%*%{${reset_color}%}"

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
