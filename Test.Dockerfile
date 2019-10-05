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

# Install knapsack_pro from GitHub repo source code
RUN mkdir -p /root/gems
WORKDIR /root/gems
RUN ls -lah
RUN git clone -b $CF_BRANCH --single-branch https://github.com/KnapsackPro/knapsack_pro-ruby.git || git clone -b master --single-branch https://github.com/KnapsackPro/knapsack_pro-ruby.git
RUN ls -lah
WORKDIR /root/gems/knapsack_pro-ruby
RUN git branch
RUN git log -n 1 | more

WORKDIR /src

RUN export KNAPSACK_PRO_REPO_PATH=/root/gems/knapsack_pro-ruby \
      bundle install
