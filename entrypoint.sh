#!/usr/bin/env bash

if [ -r /bob/build_script ]; then
  source /bob/build_script
else
  cat <<-EOF
Bob - The Cartoonish Build System
=================================

BOB_PROJECT_NAME: $BOB_PROJECT_NAME
BOB_JOB_NAME: $BOB_JOB_NAME
BOB_BUILD_NUMBER: $BOB_BUILD_NUMBER
BOB_BUILDER_TAG: $BOB_BUILDER_TAG
BOB_ARTIFACT_PATH: $BOB_ARTIFACT_PATH
BOB_PROJECT_PATH: $BOB_PROJECT_PATH
EOF
fi
