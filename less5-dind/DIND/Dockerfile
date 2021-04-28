FROM alpine:latest 
RUN apk update && apk add nginx && mkdir /run/nginx/

WORKDIR /etc/nginx/
CMD ["./nginx", "-g", "daemon off;"]
