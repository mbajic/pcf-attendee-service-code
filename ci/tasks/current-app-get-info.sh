#!/bin/bash

set -xe

pwd
env

cf api $API --skip-ssl-validation

cf login -u USERNAME -p $PWS_PWD -o "$ORGANIZATION" -s "$SPACE"

cf apps

set +e
cf apps | grep "main-$APP_SUFFIX" | grep green
if [ $? -eq 0 ]
then
  echo "green" > ./current-app-info/current-app.txt
  echo "blue" > ./current-app-info/next-app.txt
else
  echo "blue" > ./current-app-info/current-app.txt
  echo "green" > ./current-app-info/next-app.txt
fi
set -xe

echo "Current main app routes to app instance $(cat ./current-app-info/current-app.txt)"
echo "New version of app to be deployed to instance $(cat ./current-app-info/next-app.txt)"
