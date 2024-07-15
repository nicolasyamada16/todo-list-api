FROM --platform=linux/amd64 ruby:3.1.3

ARG NODE_MAJOR=18
RUN apt-get update
# Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Node
RUN apt-get install -y ca-certificates curl gnupg
RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list

# Rails API dependencies
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    apt-utils \
    libssl-dev \
    nodejs \
    mariadb-server \
    ruby-railties \
    yarn \
    git-core \
    curl \
    build-essential \
    cmake

ENV APP_HOME /myapp
ENV PATH /myapp/node_modules/.bin:$PATH

WORKDIR $APP_HOME

COPY . $APP_HOME

RUN cp $APP_HOME/config/database.example.yml $APP_HOME/config/database.yml

RUN gem install bundler:2.3.7

RUN bundle config set --local deployment true
RUN bundle config set --local without development test
RUN bundle install

RUN mkdir -p tmp/sockets
RUN mkdir -p tmp/pids

# Run Rails' asset  precompilation step.
RUN bundle exec rails assets:clobber
RUN bundle exec rails assets:precompile

# Add Tini.
ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

RUN chmod +x bin/start_release

# Configure the main process to run when running the image
CMD bin/start_release