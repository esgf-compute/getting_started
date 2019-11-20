#! /bin/bash

LOCK_FILE="${HOME}/.esgf-init-done"

[[ -e "${LOCK_FILE}" ]] && echo "Environment already initialized" && exit 0

echo -e "envs_dirs:\n - /home/jovyan/conda-envs" > /home/jovyan/.condarc

conda init bash

cat << EOF > .esgf-functions.sh
#!/bin/bash

function esgf-update {
  curl https://raw.githubusercontent.com/esgf-nimbus/getting_started/master/getting_started.ipynb -O
  curl https://raw.githubusercontent.com/esgf-nimbus/getting_started/master/esgf_search.ipynb -O
}
EOF

BASHRC="${HOME}/.bashrc"
SOURCE_LINE=". ${HOME}/.esgf-functions.sh"

[[ ! $(grep "${SOURCE_LINE}" "${BASHRC}") ]] && echo "${SOURCE_LINE}" >> "${BASHRC}"

. "${HOME}/.esgf-functions.sh"

esgf-update

touch "${LOCK_FILE}"
