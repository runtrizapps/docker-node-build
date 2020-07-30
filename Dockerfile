FROM node:latest

# Installing build tools
RUN apt-get update && \
  apt-get install -y \
  git-crypt

# bash will load volta() function via .bashrc
# using $VOLTA_HOME/load.sh
SHELL ["/bin/bash", "-c"]

# since we're starting non-interactive shell,
# we wil need to tell bash to load .bashrc manually
ENV BASH_ENV ~/.bashrc
# needed by volta() function
ENV VOLTA_HOME /root/.volta
# make sure packages managed by volta will be in PATH
ENV PATH $VOLTA_HOME/bin:$PATH

# install volta
RUN curl https://get.volta.sh | bash

RUN echo "tslint typescript prettier jest create-ts-index standard-version eslint lerna code-push-cli appcenter-cli ts-node detox react-native-cli codecov bugsnag-sourcemaps patch-package jetifier bin-version-check-cli" | xargs -n 1 $VOLTA_HOME/bin/volta install
