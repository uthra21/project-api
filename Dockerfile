FROM ruby:3.4

WORKDIR /usr/src/app

RUN apt-get update -qq && \
    apt-get install -y build-essential libsqlite3-dev nodejs && \
    rm -rf /var/lib/apt/lists/*

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

EXPOSE 3000

CMD ["bin/rails", "server", "-b", "0.0.0.0"]