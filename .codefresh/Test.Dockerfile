FROM dustinvanbuskirk/cfstep-knapsack:alpha

COPY . /src

WORKDIR /src

RUN bundle install
