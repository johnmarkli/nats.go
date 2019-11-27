FROM alpine:3.10

MAINTAINER Joe Duhamel <joe@kflow.io>

RUN apk add --update ca-certificates sudo

ADD nats-sub /usr/local/bin/nats-sub

ENV NATS_URL "nats://nats:4222"
ENV NATS_TLS "false"
ENV NATS_TLSCERT ""
ENV NATS_TLSKEY ""
ENV NATS_TLSCACERT ""

# Run via the configuration file
ENTRYPOINT ["/usr/local/bin/nats-sub"]
CMD []
