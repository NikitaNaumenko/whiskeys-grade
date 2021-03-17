FROM ruby:3.0.0

RUN apt-get update \
      && apt-get install -y build-essential libpq-dev

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y nodejs yarn

ENV BUNDLE_PATH /root/blog/vendor/bundle

WORKDIR /root/blog

RUN bundle config build.nokogiri --use-system-libraries

COPY package.json .
COPY yarn.lock .

RUN yarn install

COPY Gemfile .
COPY Gemfile.lock .


RUN bundle install --jobs $(nproc)

COPY . .

RUN NODE_ENV=production RAILS_ENV=production SECRET_KEY_BASE=key bin/rails assets:precompile
