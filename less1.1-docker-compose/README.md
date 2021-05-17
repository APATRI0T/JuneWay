# Juneway Less 1.1 
### Задача:
> 1. Поднять машину с CentOS, установить docker и docker-compose  
> 2. Написать докер композ, в котором будет 3 сервиса: 
> - nginx
> - postgresql
> - app (приложение на джанго https://gitlab.com/chumkaska1/django_blog.git) - докер файл с инсталяцией зависимостей, порт 8000
> 3. Создать нетворк для них

### Ресурсы: 
> 1. https://docs.docker.com/engine/install/centos/
> 2. https://docs.docker.com/compose/install/
> 3. https://realpython.com/django-development-with-docker-compose-and-machine/ (docker compose)
> 4. https://docs.docker.com/compose/networking/

# Решение
# 1. Подготовка 
1. Регистрируемся в Google Cloud Platform
2. Создаем виртуалку
3. Заливаем Centos
4. Открываем порт  + не забыть применить правила к нашей вм ( делается по тегу вм (network tags) и правила (target tags))
https://stackoverflow.com/questions/21065922/how-to-open-a-specific-port-such-as-9090-in-google-compute-engine

## 1.1 Установка docker в centos8:
```Bash
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce docker-ce-cli containerd.io
sudo systemctl start docker
sudo usermod -aG docker ${USER}
su - ${USER}

# docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
# bash comletitions
sudo curl     -L https://raw.githubusercontent.com/docker/compose/1.29.1/contrib/completion/bash/docker-compose     -o /etc/bash_completion.d/docker-compose
source ~/.bashrc

cd /srv/JuneWay/less1.1-docker-compose
git clone https://gitlab.com/chumkaska1/django_blog.git
```
# 2.  создаем network\volume 
```bash
docker volume create less11_django_static
docker network create DjangoBlog
```
# 3. Dockerfile для django контейнера:
```Dockerfile
From python:3.7-alpine

COPY ./django_blog/requirements.txt /app/

RUN set -ex && apk add --no-cache --virtual .build-deps postgresql-dev build-base 
RUN python -m venv /env && \
    /env/bin/pip install --upgrade pip && \
    /env/bin/pip install --no-cache-dir -r /app/requirements.txt
RUN apk add --virtual rundeps $(scanelf --needed --nobanner --recursive /env \
        | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
        | sort -u \
        | xargs -r apk info --installed \
        | sort -u) && apk del .build-deps

COPY ./django_blog/ /app/
WORKDIR /app

ENV VIRTUAL_ENV /env
ENV PATH /env/bin:$PATH
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

EXPOSE 8000
```
# 4. Docker-compose yaml
```yaml
version: '3'

services: 
    app:
        restart: unless-stopped
        build: ./app
        command: python manage.py runserver 0.0.0.0:8000
        expose: 
            - "8000"
        container_name: less11_app
        volumes: 
            - ./app/django_blog:/app/
            - django_static:/app/static    
        depends_on: 
            - db
    web:
        restart: unless-stopped
        image: nginx:1.20-alpine
        volumes: 
            - ./app/django_blog/config/nginx/django.conf:/etc/nginx/conf.d/default.conf:ro
            - django_static:/src/static
        ports: 
            - "8000:8000"
        container_name: less11_web        
    db:
        restart: unless-stopped
        image: postgres:12.0-alpine
        volumes: 
            - postgres_data:/var/lib/postgresql/data
        environment: 
            - POSTGRES_USER=postgres
            - POSTGRES_DB=postgres
        ports: 
            - "5432:5432"
        container_name: less11_db        
volumes: 
    postgres_data:
        name: less11_postgres_data
    django_static:
        external: 
            name: less11_django_static
networks: 
    default:        
        external: 
            name: DjangoBlog
```
## Собираем\запускаем
```bash
# собираем
docker-compose build
# запускаем тестовый режим
docker-compose up
# запускаем в фоновом режиме
docker-compose up -d
```

# 5. Подготовка django приложения
> https://www.digitalocean.com/community/tutorials/how-to-build-a-django-and-gunicorn-application-with-docker#step-6-%E2%80%94-writing-the-application-dockerfile
> 
```bash
# Инициализируем джангу
docker exec -it less11_app sh -c "python manage.py makemigrations && python manage.py migrate && python manage.py collectstatic"
# Создаем пользователя 
docker exec -it less11_app sh # заходим в контейнер
python manage.py createsuperuser
```

# 6. Исправляем косяки
1. Ошибка `ModuleNotFoundError: No module named 'Blog.wsgi'` = скопировать файл wsgi.py в Blog/wsgi.py
2. Конфиг NGINX: в app/django_blog/config/django.conf изменить имя сервера `web` на `app`
```bash
   upstream web {
   ip_hash;
   server app:8000;
 }
```


# Done! Мы молодцы
## Ссылочки:
> https://semaphoreci.com/community/tutorials/dockerizing-a-python-django-web-application  
> https://www.digitalocean.com/community/tutorials/how-to-build-a-django-and-gunicorn-application-with-docker
> https://testdriven.io/blog/dockerizing-django-with-postgres-gunicorn-and-nginx/