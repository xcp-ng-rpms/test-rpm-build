# test-rpm-build
Test script for the build of `xcp-ng-rpms` repos

## How to

This test is designed to be launched by github workflows to validate PRs on RPMs repos.
However it can be launched manually and locally as follows:
```
TARGET_XCP_NG_VERSION=8.2 CONTAINER_NAME=container-name /path/to/this/repo/test-rpm-build.sh /path/to/rpm/repo
```
