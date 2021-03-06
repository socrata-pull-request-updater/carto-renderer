#!/bin/bash

set -ev

# Change to the project root.
cd "$(git rev-parse --show-toplevel 2>/dev/null)"

VENV_DIR="venv"
if [ "${HUDSON_HOME}" ]; then
    VENV_DIR="${HUDSON_HOME}/carto-renderer/${VENV_DIR}"
fi

if [ ! -d "${VENV_DIR}" ]; then
    virtualenv "${VENV_DIR}"
fi
source "${VENV_DIR}"/bin/activate

DEV_FILE='dev-requirements.txt'
FROZEN_FILE='frozen.txt'

REQS=($(grep -E --invert-match '# ?test' "${DEV_FILE}" | tr "\\n" ' '))
pip install --upgrade "${REQS[@]}"

pip freeze > "${FROZEN_FILE}"
