# set -gx TERM xterm-256
set -x EDITOR /usr/bin/nvim


## TIME_STYLE
set -x TIME_STYLE "+%Y-%m-%d %H:%M:%S"


## oh-my-fish theme options
### bobthefish
# set -g default_user user
set -g theme_show_exit_status yes
set -g theme_display_user yes
set -g theme_display_sudo_user yes
set -g theme_display_jobs_verbose yes
set -g theme_color_scheme nord
set -g theme_display_node yes


## abbreviations
abbr --add --global -- gfu "git fetch upstream"
abbr --add --global -- gpo "git push origin"
abbr --add --global -- grst "git restore --staged"
abbr --add --global -- grhs "git reset --soft"
abbr --add --global -- gdn "git diff --name-only"
abbr --add --global -- gdst "git diff --staged"
alias v nvim

## zoxide
if command -v zoxide >/dev/null
  set -x _ZO_EXCLUDE_DIRS "/tmp:/tmp/*"
  zoxide init fish | source
end

## Python
set -x PYTHONDONTWRITEBYTECODE 1

### pyenv init
if command -v pyenv 1>/dev/null 2>&1
  pyenv init - | source
  pyenv init --path | source
end

### pyenv-virtualenv init
status --is-interactive; and pyenv virtualenv-init - | source


## Node.js
### fnm
fnm env --use-on-cd | source


## Rust
set -gx PATH $HOME/.cargo/bin $PATH

## per-device configs
if [ -f "$(status dirname)/device_config.fish" ]
  . $(status dirname)/device_config.fish
end
