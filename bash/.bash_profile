#### Section Initially in .bash_profile retrieved in basrc
#### in order to call .bashrc from .bash_profile without cycling
#### allowing to avoid tmux error at launch regarding prompt issues

#function conda_auto_env() {
#  if [ -e "environment.yaml" ]; then
#    ENV_NAME=$(head -n 1 environment.yaml | cut -f2 -d ' ')
#    # Check if you are already in the environment
#    if [[ $CONDA_PREFIX != *$ENV_NAME* ]]; then
#      # Try to activate environment
#      conda activate $ENV_NAME &>/dev/null
#    fi
#  fi
#}
#
#export PROMPT_COMMAND="conda_auto_env;$PROMPT_COMMAND"


source ~/.bashrc
cls


