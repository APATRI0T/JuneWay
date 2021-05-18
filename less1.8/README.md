# Juneway Less 1.8
    Иногда нужно контейнерам нужен общий волум в режиме рид онли.
    Что бы закрепить тему с волумами сделаем задачу.
    Берем композ с прошлого задания (2 нжинкса + графана)
    И модифицируем его таким образом ,что бы не копировать конфиги каждому контейнеру ,а создали в композе волюм и подключили бы его к 2м нжинксам.
    Ссылок не будет, просмотрев видео мы уже должны иметь представления что такое волюмы, но там не было этого простого момента.
    Подсказка: local driver
# Решение
> https://docs.docker.com/compose/compose-file/compose-file-v3/#volume-configuration-reference

```yaml
version: '3.9'

services: 
    nginx1:
        image: nginx:1.20-alpine
        restart: unless-stopped
        ports: 
            - "8001:8001"
        networks: 
            - Nginx1 
        volumes: 
            - Nginx:/etc/nginx/conf.d/
        container_name: less16-web1

    nginx2:
        image: nginx:1.20-alpine
        restart: unless-stopped
        ports: 
            - "8002:8001"
        networks: 
            - Nginx2
        volumes: 
            - Nginx:/etc/nginx/conf.d/
        container_name: less16-web2

    grafana:
        build: ./grafana
        restart: unless-stopped
        networks: 
            - Nginx1
            - Nginx2
        container_name: less16-grafana
        healthcheck:
            test: curl --fail -Ss http://nginx1:8001 || exit 1

networks: 
    Nginx1:
        external: 
            name: L1_6_Nginx1
    Nginx2:
        external: 
            name: L1_6_Nginx2

volumes: 
    Nginx:
        driver: local
        driver_opts: 
            type: none
            o: bind
            device: ${PWD}/Nginx/        
```