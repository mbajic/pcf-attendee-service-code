#!/bin/bash

set -e

cat ./current-app-info/current-app.txt

sed "s/APPNAME/$(cat ./current-app-info/next-app.txt)-$APP_SUFFIX/" ./attendee-service-source/manifest.yml > ./app-manifest-output/manifest.yml

cat ./app-manifest-output/manifest.yml
