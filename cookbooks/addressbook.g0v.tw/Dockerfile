FROM phusion/baseimage
MAINTAINER Chen Hsin-Yi "ossug.hychen@gmail.com"

# Set correct environment variables.
ENV HOME /root

# SSH Server
EXPOSE 22

# Expose Nginx Proxy
EXPOSE 80

CMD ["/sbin/my_init"]

# Use Taiwan mirror.
RUN sed -i -r 's#http://(.*?archive|security)\.ubuntu\.com/ubuntu#http://tw.archive.ubuntu.com/ubuntu#g' /etc/apt/sources.list
RUN apt-get -y update
RUN apt-get -y install curl build-essential libxml2-dev libxslt-dev git
RUN curl -L https://www.opscode.com/chef/install.sh | bash
RUN /opt/chef/embedded/bin/gem install --no-ri --no-rdoc berkshelf

ADD . /chef
RUN cd /chef && /opt/chef/embedded/bin/berks install --path /chef/chef-cookbooks
RUN chef-solo -c /chef/solo.rb -j /chef/dna.json 

# Postgresql isnt managed by runit, so we need start in boot.
RUN echo '#!/bin/sh\n/etc/init.d/postgresql start' >> /etc/my_init.d/01_start_postgresql.sh
RUN chmod 755 /etc/my_init/01_start_postgresql.sh
