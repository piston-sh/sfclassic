FROM alpine
LABEL maintainer="admin@deniscraig.com"

RUN apk --update --no-cache add p7zip git openssh tar gzip ca-certificates \
  && rm -rf /var/cache/apk/* /tmp/*

CMD [ "7za --help" ]