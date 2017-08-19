#!/bin/bash
set -x
set -e
set -u

cd SPIRV-Tools

GITHUB_USER=paulthomson
GITHUB_REPO=build-SPIRV-Tools

CMAKE_BUILD_TYPE="${Configuration}"
INSTALL_DIR="${PROFILE}-${Platform}-${CMAKE_BUILD_TYPE}"
COMMIT_ID="${APPVEYOR_REPO_COMMIT}"

cd "${INSTALL_DIR}"
7z a "../${INSTALL_DIR}.zip" *
cd ..

github-release \
  "${GITHUB_USER}/${GITHUB_REPO}" \
  "v-${COMMIT_ID}" \
  "${COMMIT_ID}" \
  "$(echo -e "Automated build.\n$(git log --graph -n 3 --abbrev-commit --pretty='format:%h - %s <%an>')")" \
  "${INSTALL_DIR}.zip"

