# pyenv init
if command -v pyenv 1>/dev/null 2>&1
  set -Ux PYENV_ROOT $HOME/.pyenv
  set -Ux fish_user_paths $PYENV_ROOT/bin $fish_user_paths
  pyenv init - | source
  pyenv init --path | source
end

# pyenv-virtualenv init
status --is-interactive; and pyenv virtualenv-init - | source


# oh-my-fish theme options
## bobthefish
#set -g default_user user
set -g theme_show_exit_status yes
set -g theme_display_user yes
set -g theme_display_sudo_user yes
set -g theme_display_jobs_verbose yes
set -g theme_color_scheme nord
