#!/bin/bash

set -e

env

export NEXT_APP_COLOR=$(cat ./current-app-info/next-app.txt)
export NEXT_APP_URL=http://$NEXT_APP_COLOR-$APP_SUFFIX.$APP_DOMAIN/

if [ -z $NEXT_APP_URL ]; then
  echo "NEXT_APP_URL not set"
  exit 1
fi

apt-get update && apt-get install -y curl

pushd attendee-service-source
  echo "Running smoke tests for Attendee Service deployed at $NEXT_APP_URL"
  smoke-tests/bin/test $NEXT_APP_URL
popd

exit 0

