# Pull ubuntu 
FROM ubuntu:22.04


# Update
RUN apt update -y
RUN apt upgrade -y

# Dependencies
RUN apt install -y build-essential libffi-dev perl zlib1g-dev wget
RUN apt install -y autoconf automake libpcre3-dev libnl-3-dev libsqlite3-dev libssl-dev ethtool build-essential g++ libnl-genl-3-dev libgcrypt20-dev libtool python3-distutils
RUN apt install -y pkg-config

# Pretty sure that these aren't needed
#RUN mkdir duo
#RUN cd duo/

# Insall DUO
RUN wget --content-disposition https://dl.duosecurity.com/duoauthproxy-latest-src.tgz
RUN tar xzf duoauthproxy-5.7.1-src.tgz
RUN cd duoauthproxy-5.7.1-41087a5-src/ &&  make


VOLUME /home/ac_admin/duo_auth_proxy/1:/opt/duoauthproxy
VOLUME /home/ac_admin/duo_auth_proxy/2:/etc/init.d/duoauthproxy
VOLUME /home/ac_admin/duo_auth_proxy/3:/etc/systemd/system/duoauthproxy.service
VOLUME /home/ac_admin/duo_auth_proxy/4:/lib/systemd/system/duoauthproxy.service

#RUN echo $PWD
RUN cd /duoauthproxy-5.7.1-41087a5-src/duoauthproxy-build/ && ./install --install-dir /opt/duoauthproxy --service-user duo_authproxy_svc --log-group duo_authproxy_grp --create-init-script yes

# Coopy config file to image 
COPY authproxy.cfg /opt/duoauthproxy/conf/

# Start server 
#RUN /opt/duoauthproxy/bin/authproxyctl start

#ENTRYPOINT /opt/duoauthproxy/bin/authproxyctl start && CMD tail -f /dev/null
#ENTRYPOINT  while true; do sleep 1; done
CMD /opt/duoauthproxy/bin/authproxyctl start && tail -f /dev/null

