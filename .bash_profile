for file in ~/.{bash_prompt,exports,aliases}; do
    [ -r "$file" ] && source "$file"
done
unset file

# Initialize RVM
# source ~/.rvm/scripts/rvm

# Initialize autoenv
source /usr/local/bin/activate.sh

# Initialize virtualenvwrapper
source /usr/local/bin/virtualenvwrapper.sh

# Append history entries
shopt -s histappend

# Enable bash autocompletion
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

# The use_env call below is a reusable command to activate/create a new Python
# virtualenv, requiring only a single declarative line of code in your .env files.
# It only performs an action if the requested virtualenv is not the current one.
use_env() {
  typeset venv
  venv="$1"
  if [[ `basename "${VIRTUAL_ENV:t}"` != "$venv" ]]; then
    if workon | grep $venv > /dev/null; then
      workon "$venv"
    else
      echo -n "Create virtualenv $venv now? (Yn) "
      read answer
      if [[ "$answer" == "Y" ]]; then
        mkvirtualenv "$venv"
      fi
    fi
  fi
}

[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh  # This loads NVM

# Initialize direnv
eval "$(direnv hook bash)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/eero/google-cloud-sdk/path.bash.inc' ]; then source '/Users/eero/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/eero/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/eero/google-cloud-sdk/completion.bash.inc'; fi

# Pyenv
export PATH="/Users/eero/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
