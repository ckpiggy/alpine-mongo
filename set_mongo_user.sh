#!/bin/bash

USER=${MONGODB_USER:-"admin"}
PASS=${MONGODB_PASS:-"admin_password"}
DATABASE=${MONGODB_DATABASE:-"admin"}
DBUSER=${DB_USER:-"db_user"}
DBPWD=${DB_PWD:-"db_pwd"}

RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MongoDB service startup"
    sleep 5
    mongo admin --eval "help" >/dev/null 2>&1
    RET=$?
done

echo "=> Creating an ${USER} user with a ${PASS} password in MongoDB"

mongo admin --eval "db.createUser({user: '$USER', pwd: '$PASS', \
roles:['userAdminAnyDatabase', 'dbAdminAnyDatabase', 'readWriteAnyDatabase']\
});"

if [ "$DATABASE" != "admin" ]; then
    echo "=> Creating an ${USER} user with a ${_word} password in ${DATABASE}"
    mongo admin -u $USER -p $PASS << EOF
use $DATABASE
db.createUser({user: '$DBUSER', pwd: '$DBPWD', roles:[{role:'dbOwner',db:'$DATABASE'}]})
EOF
fi


echo "=> Done!"
touch /data/db/.mongodb_password_set
echo "========================================================================"
echo "You can now connect to this MongoDB server using:"
echo ""
echo "    mongo -u $USER -p $PASS --host <host> --port <port>"
echo ""
echo "========================================================================"

