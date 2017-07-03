FROM alpine:edge

RUN apk add --update bash && rm -rf /var/cache/apk/*

RUN \
apk add --no-cache mongodb && \
rm /usr/bin/mongoperf

VOLUME /data/db
EXPOSE 27017 28017

ADD run.sh /run.sh
ADD set_mongo_user.sh /set_mongo_user.sh

RUN ["chmod", "755", "/set_mongo_user.sh"]

CMD ["/run.sh"]
