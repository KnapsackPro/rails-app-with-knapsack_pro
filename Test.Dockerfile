FROM dustinvanbuskirk/cfstep-knapsack:alpha

COPY . /src

WORKDIR /src

RUN USE_KNAPSACK_PRO_FROM_RUBYGEMS=true bundle install
