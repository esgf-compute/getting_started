#! /bin/bash

[[ -e "${HOME}/.init-done" ]] && echo "Environment already initialized" && exit 0

echo -e "envs_dirs:\n - /home/jovyan/conda-envs" > /home/jovyan/.condarc

conda init bash

mkdir -p ${HOME}/getting_started

cd ${HOME}/getting_started

curl https://raw.githubusercontent.com/esgf-nimbus/getting_started/master/getting_started.ipynb -O
curl https://raw.githubusercontent.com/esgf-nimbus/getting_started/master/esgf_search.ipynb -O

touch ${HOME}/.init-done
