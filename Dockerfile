FROM ruby:2.1

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        postgresql-client \
        nodejs \
        libmagickwand-dev \
        libmagickcore-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app
COPY Gemfile* ./
RUN bundle install --without development test
COPY . .

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
