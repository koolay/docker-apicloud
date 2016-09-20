FROM phusion/baseimage:0.9.19

# Set correct environment variables.
ENV HOME /root

#   Build system and git.
#RUN /bd_build/utilities.sh
#   Python support.

# ...put your own build instructions here...

RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends build-essential nodejs

ADD ./bootstrap.sh /etc/my_init.d/
RUN mkdir /etc/service/app
ADD ./app.sh /etc/service/app/run
RUN chmod +x /etc/my_init.d/bootstrap.sh && chmod +x /etc/service/app/run
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && apt-get autoremove --purge --yes build-essential

#WORKDIR /home/app/$APP_NAME
# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]