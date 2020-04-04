FROM debian:buster

RUN echo "deb-src http://deb.debian.org/debian buster main contrib non-free" >> /etc/apt/sources.list

RUN apt clean && \
 apt update && \
 apt install -y dpkg-dev

RUN chmod -Rv 700 /var/cache/apt/archives/partial/ && \
 apt source squid3

COPY rules /squid-4.6/debian/rules
RUN apt install -y devscripts build-essential libdbi-perl && \
 cd squid-4.6 && \
 apt install -y ed pkg-config cdbs libcppunit-dev libcap2-dev libdb-dev libecap3-dev libexpat1-dev libgnutls28-dev libkrb5-dev comerr-dev libldap2-dev libnetfilter-conntrack-dev libpam0g-dev libsasl2-dev libxml2-dev nettle-dev && \
 debuild -us -uc -b

RUN dpkg -i squid*.deb || (apt --fix-broken install -y && dpkg -i squid*.deb)

COPY squid.conf /etc/squid/squid.conf

CMD ["/usr/sbin/squid", "--foreground"]