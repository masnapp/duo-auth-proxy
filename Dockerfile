# Pull ubuntu 22.04
FROM ubuntu:22.04

# Update 
RUN apt update -y && apt upgrade -y
# RUN apt upgrade -y

# Install Dependencies
RUN apt install -y build-essential libffi-dev perl zlib1g-dev wget \
    autoconf automake libpcre3-dev libnl-3-dev libsqlite3-dev libssl-dev ethtool \
    build-essential g++ libnl-genl-3-dev libgcrypt20-dev libtool python3-distutils \
    pkg-config
# RUN apt install -y autoconf automake libpcre3-dev libnl-3-dev libsqlite3-dev libssl-dev ethtool build-essential g++ libnl-genl-3-dev libgcrypt20-dev libtool python3-distutils
# RUN apt install -y pkg-config

# Make diectory for duo tar extraction 
RUN mkdir duoauthproxy-latest
# RUN wget --content-disposition https://dl.duosecurity.com/duoauthproxy-latest-src.tgz | tar -xz - -C duoauthproxy-latest --strip-components=1
# Download latest version of Duo Auth Proxy and extract into previously made folder 
RUN wget -O - https://dl.duosecurity.com/duoauthproxy-latest-src.tgz | tar -xzv --transform 's:^[^/]*:duoauthproxy-latest:'
# Make program 
RUN cd duoauthproxy-latest && make

# Shouldn't need these with Docker-Compose 
# VOLUME /home/ac_admin/duo_auth_proxy/1:/opt/duoauthproxy
# VOLUME /home/ac_admin/duo_auth_proxy/2:/etc/init.d/duoauthproxy
# VOLUME /home/ac_admin/duo_auth_proxy/3:/etc/systemd/system/duoauthproxy.service
# VOLUME /home/ac_admin/duo_auth_proxy/4:/lib/systemd/system/duoauthproxy.service

RUN cd /duoauthproxy-latest/duoauthproxy-build/ && ./install --install-dir /opt/duoauthproxy --service-user duo_authproxy_svc --log-group duo_authproxy_grp --create-init-script yes

# Coopy config file to image 
COPY authproxy.cfg /opt/duoauthproxy/conf/

# Start DUO service. DUO runs in the background causing container to close after starting 
# tail -f /dev/null runs never ending to keep container running 
CMD /opt/duoauthproxy/bin/authproxyctl start && tail -f /dev/null

