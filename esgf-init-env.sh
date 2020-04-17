#! /bin/bash

set -x 

LOCK_FILE="${HOME}/.compute-lock"
GETTING_STARTED_URL="https://raw.githubusercontent.com/esgf-nimbus/getting_started/master/getting_started.ipynb"

cat << EOF > "${HOME}/.init-functions.sh"
#!/bin/bash

function compute_init {
  if [[ ! -e ${LOCK_FILE} ]]
  then
    echo -e "envs_dirs:\n - /home/jovyan/conda-envs" > /home/jovyan/.condarc

    conda init bash

    getting_started

    init_lock
  fi
}

function download_file {
  curl \${1} -O
}

function getting_started {
  download_file "${GETTING_STARTED_URL}"
}

function init_lock {
  touch ${LOCK_FILE}
}

function remove_lock {
  rm ${LOCK_FILE}
}
EOF

BASHRC="${HOME}/.bashrc"
SOURCE_LINE=". ${HOME}/.init-functions.sh"

# We want .esgf-functions.sh to be loaded everytime
[[ ! $(grep "${SOURCE_LINE}" "${BASHRC}") ]] && echo "${SOURCE_LINE}" >> "${BASHRC}"

# Source the functions now to use them.
. "${HOME}/.init-functions.sh"

GETTING_STARTED="${HOME}/getting_started.ipynb"

compute_init
