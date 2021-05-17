# Juneway Less 1.6
## Задача:
Напишите Докер компоСТ (docker-compose.yml со сл условиями:
1. 3 контейнера nginx1 nginx2 grafana (https://hub.docker.com/r/grafana/grafana)
2. Nginx1 port 8001 на Grafana  
   Nginx2 port 8002 на Grafana
3. Grafana не пробрасывать ничего наружу.  Она не должна подниматься если вы её стопорите руками.
4. Nginx1 и Nginx2 в разных сетях.
5. И конечно 2 конфига нжинкса которые будут пробрасывать на Grafana (пример конфиг с лес1.1 джанго конф)  
**Ответ в Гитлаб**

## Задача со *
Сделать хелсчек Nginx1 в контейнере с Grafana  
Уронить Nginx1 посмотреть что будет)  
Скрины в ответ на задачу. Либо пастбин.


# Решение
## 1.  создаем network\volume 
```bash
docker network create L1_6_Nginx1
docker network create L1_6_Nginx2
```
## 2. Dockerfile для графаны:
> чтоб работал healthcheck нужно доставить curl в контейнер с графаной.
```Dockerfile
FROM grafana/grafana:7.5.6

USER root
RUN apk add curl 
```
## 4. Docker-compose yaml
```yaml
version: '3.1'

services: 
    nginx1:
        image: nginx:1.20-alpine
        restart: unless-stopped
        ports: 
            - "8001:8001"
        networks: 
            - Nginx1 
        volumes: 
            - ./Nginx1/nginx1.conf:/etc/nginx/conf.d/default.conf
        container_name: less16-web1

    nginx2:
        image: nginx:1.20-alpine
        restart: unless-stopped
        ports: 
            - "8002:8002"
        networks: 
            - Nginx2
        volumes: 
            - ./Nginx2/nginx2.conf:/etc/nginx/conf.d/default.conf
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
```
## 5. Healthcheck
мы добавили в docker-compose.yml описание проверки работоспособности контейнера
```yaml
healthcheck:
            test: curl --fail -Ss http://nginx1:8001 || exit 1
```
И если после этого прибить nginx1 (`docker stop less16_web1`), то через 30сек увидим, что контейнеру с графаной присвоится статус `Up (unhealthy)`
## Добавить правила в фаервол GCP
    MyProject - Networking - Firewall
    Открыть порты 8001,8002
    
## Собираем\запускаем
```bash
# собираем
docker-compose build
# запускаем тестовый режим
docker-compose up
# запускаем в фоновом режиме
docker-compose up -d
```
