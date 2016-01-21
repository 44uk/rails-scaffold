FROM ubuntu:14.04
RUN apt-get update

FROM nkwhr/ruby-ubuntu
RUN apt-get update
RUN apt-get -y install libmysqlclient-dev nodejs
RUN git clone https://github.com/yukku0423/rails-scaffold.git project-a
RUN cd project-a && bundle install --without development:production -j $(getconf _NPROCESSORS_ONLN)
WORKDIR /project-a
ENV RAILS_ENV test
CMD git pull && \
  bundle install -j $(getconf _NPROCESSORS_ONLN) && \
  bundle binstubs rake && \
  bin/rake db:create db:migrate && \
  bin/rake spec
