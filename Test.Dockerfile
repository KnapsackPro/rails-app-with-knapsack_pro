FROM ruby:2.6.5-alpine3.10

# Prepare Docker image for Nokogiri

RUN apk add --update \
  build-base \
  libxml2-dev \
  libxslt-dev \
  jq \
  nodejs \
  npm \
  postgresql-dev \
  python3-dev \
  sqlite-dev \
  git \
  && rm -rf /var/cache/apk/*

# Install AWS CLI

RUN pip3 install awscli

# Use libxml2, libxslt a packages from alpine for building nokogiri
RUN bundle config build.nokogiri --use-system-libraries

# Install Codefresh CLI
RUN wget https://github.com/codefresh-io/cli/releases/download/v0.31.1/codefresh-v0.31.1-alpine-x64.tar.gz
RUN tar -xf codefresh-v0.31.1-alpine-x64.tar.gz -C /usr/local/bin/

COPY . /src

WORKDIR /src

RUN mkdir -p ~/gems
RUN cd ~/gems && ls -lah
RUN cd ~/gems && \
      git clone -b $CF_BRANCH --single-branch https://github.com/KnapsackPro/knapsack_pro-ruby.git || git clone -b master --single-branch https://github.com/KnapsackPro/knapsack_pro-ruby.git
RUN cd ~/gems && ls -lah
RUN cd ~/gems/knapsack_pro-ruby && git branch
RUN cd ~/gems/knapsack_pro-ruby && git log -n 1 | more

RUN export KNAPSACK_PRO_REPO_PATH=~/gems/knapsack_pro-ruby \
      bundle install
