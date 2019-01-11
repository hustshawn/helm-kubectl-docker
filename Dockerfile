FROM alpine:3.7

MAINTAINER Shawn Zhang <hustshawn@gmail.com>

ENV HELM_VERSION=v2.11.0
ENV HELM_FILENAME=helm-${HELM_VERSION}-linux-amd64.tar.gz


RUN apk add --update ca-certificates \
    && apk add --update curl python3 groff less\
    && apk add --update -t deps gettext tar gzip bash\
    && curl -L https://storage.googleapis.com/kubernetes-helm/${HELM_FILENAME} | tar xz && mv linux-amd64/helm /bin/helm && rm -rf linux-amd64

RUN helm init --client-only \
    && apk add git && helm plugin install https://github.com/hypnoglow/helm-s3.git

RUN pip3 install awscli \
    && apk del --purge deps \
    && rm /var/cache/apk/*

CMD [ "/bin/sh" ]
