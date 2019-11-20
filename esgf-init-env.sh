#! /bin/bash

cat << EOF > .init-functions.sh
#!/bin/bash

function compute_init {
  echo -e "envs_dirs:\n - /home/jovyan/conda-envs" > /home/jovyan/.condarc

  conda init bash
}

GETTING_STARTED_URL="https://raw.githubusercontent.com/esgf-nimbus/getting_started/master/getting_started.ipynb"
ESGF_SEARCH_URL="https://raw.githubusercontent.com/esgf-nimbus/getting_started/master/esgf_search.ipynb"

function download_file {
  curl ${1} -O
}

alias getting_started=download_file "${GETTING_STARTED_URL}"
alias esgf_search=download_file "${ESGF_SEARCH_URL}"
EOF

BASHRC="${HOME}/.bashrc"
SOURCE_LINE=". ${HOME}/.esgf-functions.sh"

# We want .esgf-functions.sh to be loaded everytime
[[ ! $(grep "${SOURCE_LINE}" "${BASHRC}") ]] && echo "${SOURCE_LINE}" >> "${BASHRC}"

# Source the functions now to use them.
. "${HOME}/.esgf-functions.sh"

LOCK_FILE="${HOME}/.compute-lock"
GETTING_STARTED="${HOME}/getting_started.ipynb"

if [[ ! -e "${LOCK_FILE}" ]]; then
  compute_init

  getting_started

  esgf_search

  touch "${LOCK_FILE}"
fi

if [[ ! -e "${GETTING_STARTED}" ]]; then
  getting_started
else
  echo "TODO check if getting_started needs to be updated."
fi
