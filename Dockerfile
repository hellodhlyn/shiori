FROM ruby:3.2-slim

RUN apt update -qq && apt install -y build-essential libpq-dev libjemalloc2

WORKDIR /usr/src/app
RUN gem install bundler -v 2.4.12

COPY Gemfile* .
RUN bundle config set --local deployment true
RUN bundle install

COPY . .

ENV LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.2
EXPOSE 3000
CMD ["bundle", "exec", "rails", "s"]
