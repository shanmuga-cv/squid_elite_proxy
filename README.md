# squid_elite_proxy

Based on https://metahackers.pro/setup-high-anonymous-elite-proxy/ 

Builds a docker image with squid proxy compiled with `--enable-http-violations` option, and configured to 
remove all http headers to expose proxy.

# usage 

Start the container

    docker-compose up -d

This would expose the squid proxy on port 3128.

# build

    docker build . -t shanmugacv/squid_elite_proxy:latest