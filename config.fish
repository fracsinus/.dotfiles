# pyenv init
if command -v pyenv 1>/dev/null 2>&1
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

# abbreviations

abbr --add --global -- gfu "git fetch upstream"
abbr --add --global -- gpo "git push origin"
abbr --add --global -- grst "git restore --staged"
abbr --add --global -- grhs "git reset --soft"
