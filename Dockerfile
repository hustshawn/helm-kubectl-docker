FROM alpine:3.7

MAINTAINER Shawn Zhang <hustshawn@gmail.com>

ENV KUBE_LATEST_VERSION=v1.11.5
ENV HELM_VERSION=v2.11.0
ENV HELM_FILENAME=helm-${HELM_VERSION}-linux-amd64.tar.gz


RUN apk add --update ca-certificates \
 && apk add --update -t deps curl  \
 && apk add --update gettext tar gzip \
 && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
 && curl -L https://storage.googleapis.com/kubernetes-helm/${HELM_FILENAME} | tar xz && mv linux-amd64/helm /bin/helm && rm -rf linux-amd64 \
 && chmod +x /usr/local/bin/kubectl \
 && apk del --purge deps \
 && rm /var/cache/apk/* \
 && apk add curl

ENTRYPOINT ["/bin/helm"]
