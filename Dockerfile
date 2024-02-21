FROM ruby:3.2.2

RUN apt-get update -qq && apt-get install -y nodejs build-essential default-mysql-client yarn vim

ENV ROOT /app
RUN mkdir ${ROOT}
WORKDIR ${ROOT}

ADD ./Gemfile ${ROOT}/Gemfile
ADD ./Gemfile.lock ${ROOT}/Gemfile.lock

RUN bundle install

ADD . ${ROOT}