#! /bin/bash

GETTING_STARTED_URL="https://raw.githubusercontent.com/esgf-nimbus/getting_started/master/getting_started.ipynb"

cd "${HOME}"

echo -e "envs_dirs:\n - /home/jovyan/conda-envs" > "${HOME}/.condarc"

if [[ -e "${HOME}/getting_started.ipynb" ]]
then
  rm "${HOME}/getting_started.ipynb"

  sync
fi

curl -LO "${GETTING_STARTED_URL}"
