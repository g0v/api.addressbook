FROM linux/chef-solo
MAINTAINER Chen Hsin-Yi "ossug.hychen@gmail.com"

ADD . /chef
RUN cd /chef && /opt/chef/embedded/bin/berks install --path /chef/chef-cookbooks
RUN chef-solo -c /chef/solo.rb -j /chef/dna.json
