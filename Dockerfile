FROM alpine:3.5
MAINTAINER Albert Chan

# Adapted from https://github.com/pmbauer/alpine-elixir

# Important!  Update this no-op ENV variable when this Dockerfile
# is updated with the current date. It will force refresh of all
# of the base images and things like `apt-get update` won't be using
# old cached versions when the Dockerfile is built.
ENV REFRESHED_AT=2017-04-18

# Set environment variables
ENV ELIXIR_VERSION 1.4.2

# Update base packages and install ncurses
RUN apk --no-cache --update add ncurses-libs && rm -rf /var/cache/apk/*

# Add edge repos tagged so that we can selectively install edge packages
RUN echo 'http://dl-4.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories

# Install Erlang
RUN apk --update add erlang && rm -rf /var/cache/apk/*

# Install Elixir
RUN apk --update add --virtual build-dependencies wget ca-certificates && \
    wget https://github.com/elixir-lang/elixir/releases/download/v${ELIXIR_VERSION}/Precompiled.zip && \
    mkdir -p /opt/elixir-${ELIXIR_VERSION}/ && \
    unzip Precompiled.zip -d /opt/elixir-${ELIXIR_VERSION}/ && \
    rm Precompiled.zip && \
    apk del build-dependencies && \
    rm -rf /etc/ssl && \
    rm -rf /var/cache/apk/*

ENV PATH $PATH:/opt/elixir-${ELIXIR_VERSION}/bin

CMD ["/bin/sh"]

