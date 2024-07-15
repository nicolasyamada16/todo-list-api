FROM ruby:3.3.0

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

RUN gem install bundler

COPY Gemfile $APP_HOME/Gemfile
COPY Gemfile.lock $APP_HOME/Gemfile.lock

RUN bundle install

ADD . $APP_HOME
RUN cp $APP_HOME/config/database.example.yml $APP_HOME/config/database.yml

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
