#!/bin/bash
set -x
set -e
set -u

mkdir temp
cd temp

GITHUB_RELEASE_TOOL_USER="paulthomson"
GITHUB_RELEASE_TOOL_VERSION="v1.0.9.1"
GITHUB_RELEASE_TOOL_ARCH="windows_amd64"


curl -fsSL -o github-release.tar.gz https://github.com/${GITHUB_RELEASE_TOOL_USER}/github-release/releases/download/${GITHUB_RELEASE_TOOL_VERSION}/github-release_${GITHUB_RELEASE_TOOL_VERSION}_${GITHUB_RELEASE_TOOL_ARCH}.tar.gz

7z x github-release.tar.gz
7z x github-release.tar
cd ..

git clone https://github.com/KhronosGroup/SPIRV-Tools.git ${CLONE_DIR}
cd ${CLONE_DIR}
git checkout $(cat ../COMMIT_ID)
git clone https://github.com/KhronosGroup/SPIRV-Headers.git external/spirv-headers
cd external/spirv-headers
git checkout $(cat ../../../COMMIT_ID_HEADERS)
