#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"
PIPELINE=${1:-postgres-patch}
RED='\033[1;31m'
NC='\033[0m' # No Color

lpass status > /dev/null
if [[ $? != 0 ]]; then
  echo -e "${RED}Error${NC}: You must log into lastpass before running this script."
  exit 1
fi

fly \
  -t prod \
  set-pipeline \
  -p $PIPELINE \
  -c $DIR/pipeline.yml \
  -l <(lpass show --notes "Shared-Data GPDB/postgres-patch-ci-secrets")
