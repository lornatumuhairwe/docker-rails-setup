FROM ruby:2.5-alpine

RUN apk update -qq && apk add --update alpine-sdk postgresql-dev nodejs yarn tzdata

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN bundle install

COPY . .

LABEL maintainer="Lorna Tumuhairwe <lornatumuhairwe@gmail.com>" \
      version="1.0"

EXPOSE 3000

CMD rails s --port=3000 -b='0.0.0.0'
