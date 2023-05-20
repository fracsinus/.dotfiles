# set -gx TERM xterm-256

set -x EDITOR /usr/bin/nvim
set -x PATH $HOME/.bin $PATH
set -x PATH $HOME/glue/bin $HOME/maven/bin $PATH
set -x JAVA_HOME /usr/lib/jvm/default
set -x SPARK_HOME $HOME/spark
set -x SPARK_CONF_DIR $HOME/spark/conf
set -x PYTHONPATH $SPARK_HOME/python/:$SPARK_HOME/python/lib/py4j-0.10.9-src.zip:$HOME/glue/PyGlue.zip $PYTHONPATH

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
set -g theme_display_node yes

# abbreviations

abbr --add --global -- gfu "git fetch upstream"
abbr --add --global -- gpo "git push origin"
abbr --add --global -- grst "git restore --staged"
abbr --add --global -- grhs "git reset --soft"
abbr --add --global -- gdn "git diff --name-only"
alias v nvim

# fnm

fnm env --use-on-cd | source

# TIME_STYLE

set -x TIME_STYLE "+%Y-%m-%d %H:%M:%S"
