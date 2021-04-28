FROM debian:9 as build
RUN apt update && \
    apt install -y \
        wget \
        gcc \
        make  \
        libpcre3 \
        libpcre3-dev \
        zlib1g \
        zlib1g-dev \
        libssl-dev
RUN wget http://nginx.org/download/nginx-1.20.0.tar.gz && \
    tar xfvz nginx-1.20.0.tar.gz && \
    cd nginx-1.20.0 && \
    ./configure && \
    make && make -j4 install 

FROM debian:9
WORKDIR /usr/local/nginx/sbin
COPY --from=build /usr/local/nginx/sbin/nginx .
RUN mkdir ../logs && mkdir ../conf && touch ../logs/error.log && chmod +x nginx
CMD ["./nginx", "-g", "daemon off;"]
