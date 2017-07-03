#!/bin/bash
set -m

echo "Hello from run"

cmd="mongod --auth"

$cmd &

if [ ! -f /data/db/.mongodb_password_set ]; then
   /set_mongo_user.sh
fi

fg