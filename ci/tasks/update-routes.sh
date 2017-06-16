#!/bin/bash

set -e

pwd
env

cf api $API --skip-ssl-validation

cf login -u $USERNAME -p $PASSWORD -o "$ORGANIZATION" -s "$SPACE"

cf apps

cf routes

export DOMAIN_NAME=$APP_DOMAIN
export MAIN_ROUTE_HOSTNAME=main-$APP_SUFFIX

export NEXT_APP_COLOR=$(cat ./current-app-info/next-app.txt)
export NEXT_APP_HOSTNAME=$NEXT_APP_COLOR-$APP_SUFFIX

export CURRENT_APP_COLOR=$(cat ./current-app-info/current-app.txt)
export CURRENT_APP_HOSTNAME=$CURRENT_APP_COLOR-$APP_SUFFIX

echo "Mapping main app route to point to $NEXT_APP_HOSTNAME instance"
cf map-route $NEXT_APP_HOSTNAME $APP_DOMAIN --hostname $MAIN_ROUTE_HOSTNAME

cf routes

echo "Removing previous main app route that pointed to $CURRENT_APP_HOSTNAME instance"

set +e
cf unmap-route $CURRENT_APP_HOSTNAME $APP_DOMAIN --hostname $MAIN_ROUTE_HOSTNAME
set -e

echo "Routes updated"

cf routes
