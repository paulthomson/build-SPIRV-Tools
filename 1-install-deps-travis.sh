#!/bin/bash
set -x
set -e
set -u

sudo mkdir -p /data/bin
sudo chmod uga+rwx /data/bin

GITHUB_RELEASE_TOOL_USER="paulthomson"
GITHUB_RELEASE_TOOL_VERSION="v1.0.9.1"


if [ "$(uname)" == "Darwin" ];
then
  brew install ninja
  GITHUB_RELEASE_TOOL_ARCH="darwin_amd64"
fi

if [ "$(uname)" == "Linux" ];
then
  sudo apt-get update
  sudo apt-get -y install cmake ninja-build
  GITHUB_RELEASE_TOOL_ARCH="linux_amd64"
fi

pushd /data/bin
wget "https://github.com/${GITHUB_RELEASE_TOOL_USER}/github-release/releases/download/${GITHUB_RELEASE_TOOL_VERSION}/github-release_${GITHUB_RELEASE_TOOL_VERSION}_${GITHUB_RELEASE_TOOL_ARCH}.tar.gz"
tar xf "github-release_${GITHUB_RELEASE_TOOL_VERSION}_${GITHUB_RELEASE_TOOL_ARCH}.tar.gz"
popd

git clone https://github.com/KhronosGroup/SPIRV-Tools.git
cd SPIRV-Tools
git checkout $(cat ../COMMIT_ID)
git clone https://github.com/KhronosGroup/SPIRV-Headers.git external/spirv-headers
cd external/spirv-headers
git checkout $(cat ../../../COMMIT_ID_HEADERS)


