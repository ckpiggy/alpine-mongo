Usage

build:

    docker build -t mongo-alpine .
    
run:

    docker run -e MONGODB_USER="user" \
    -e MONGODB_PASS="user_pwd" \
    -e MONGODB_DATABASE="db_name" \
    -d \
    -p 27017:27017 \
    mongo-alpine

then you will see logs in container

    ========================================================================
    You can now connect to this MongoDB server using:

        mongo db_name -u user -p user_pwd --host <host> --port <port>

    ========================================================================

