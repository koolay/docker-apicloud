FROM phusion/baseimage:0.9.19

# Set correct environment variables.
ENV HOME /root

#   Build system and git.
#RUN /bd_build/utilities.sh
#   Python support.

# ...put your own build instructions here...

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends build-essential nodejs git python2.7 \
    && ln -s /usr/bin/python2.7 /usr/local/bin/python

ADD ./bootstrap.sh /etc/my_init.d/
COPY ./package.json /root/package.json
WORKDIR /home/app/webapp
RUN npm install -g pm2 sails && npm install --prefix /root/
RUN mkdir /etc/service/app
ADD ./app.sh /etc/service/app/run
RUN chmod +x /etc/my_init.d/bootstrap.sh && chmod +x /etc/service/app/run
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && apt-get autoremove --purge --yes build-essential git

ENV APP_NAME apicloud
ENV APP app.js
VOLUME ["/home/app/webapp"]
# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]
