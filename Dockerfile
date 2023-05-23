FROM ruby:3.2.2
RUN apt-get update
RUN mkdir -p /app
COPY . /app
WORKDIR /app
RUN bundle install
CMD rails s -b 0.0.0.0
