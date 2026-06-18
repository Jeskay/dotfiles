# Update the top of your ~/.zshrc file to this:
if [[ -n "$NVIM" || -n "$VIMRUNTIME" ]]; then
  export IN_NVIM=1
  typeset -g POWERLEVEL10K_SHELL_INTEGRATION_OSC7=false
  typeset -g POWERLEVEL10K_RIGHT_PROMPT_ELEMENTS=()
  RPROMPT=""

  typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=false
  typeset -g POWERLEVEL9K_SHOW_RULER=false
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -z "$NVIM" ]]; then
  if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  fi
fi

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi


# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Prompt plugin
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Other plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# Load completions
autoload -U compinit && compinit

# Keybindings
bindkey -e

# History
HISTSIZE=2000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Aliases
alias codex='HTTP_PROXY="http://10.133.0.50:8888" HTTPS_PROXY="http://10.133.0.50:8888" ALL_PROXY="http://10.133.0.50:8888" /home/khrolenko/.nvm/versions/node/v24.16.0/bin/codex'

# bun completions
[ -s "/home/jeskay/.bun/_bun" ] && source "/home/jeskay/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"


# >>> Codex installer >>>
export PATH="/home/jeskay/.local/bin:$PATH"
# <<< Codex installer <<<

# PATH variables
export PATH="/home/jeskay/.cargo/bin:$PATH"
export SUDO_EDITOR="nvim"

# NVM variables
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
