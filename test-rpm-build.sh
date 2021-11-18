#!/usr/bin/env bash

# $1: Path to a `xcp-ng-rpms` repo to test its build
# TARGET_XCP_NG_VERSION: env var used to define the XCP-ng version to used (eg: 8.2)
# CONTAINER_NAME: env var used to define the name of the container created by the env builder

set -eux

BUILD_ENV_PATH=/tmp/build-env
mkdir -p "$BUILD_ENV_PATH"

git clone https://github.com/xcp-ng/xcp-ng-build-env.git "$BUILD_ENV_PATH"

TARGET_XCP_NG_VERSION=${TARGET_XCP_NG_VERSION:-8.2}
"$BUILD_ENV_PATH"/build.sh "$TARGET_XCP_NG_VERSION"

REPO_PATH="$1"

CONTAINER_NAME=${CONTAINER_NAME:-build-env}
ADDITIONAL_REPOS=xcp-ng-staging,xcp-ng-testing
python "$BUILD_ENV_PATH"/run.py --name "$CONTAINER_NAME" \
    --fail-on-error \
    --enablerepo "$ADDITIONAL_REPOS" \
    -l "$REPO_PATH" \
    -b "$TARGET_XCP_NG_VERSION" \
    --rm

rm -rf "$BUILD_ENV_PATH"
