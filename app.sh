#!/bin/bash

set -e

if [ -z "$NODE_ENV" ]; then
    export NODE_ENV=development
fi

pm2 start -x $APP --name="$APP_NAME" --no-daemon --watch
