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

cd /srv/
git clone github.com:APATRI0T/JuneWay.git
```
# 2. Docker-compose
```bash
docker-compose build
docker-compose up -d
```
# 3. Подготовка django приложения
> https://www.digitalocean.com/community/tutorials/how-to-build-a-django-and-gunicorn-application-with-docker#step-6-%E2%80%94-writing-the-application-dockerfile
> 
```bash
# Инициализируем джангу
docker run -it nginx:serg-v1 sh -c "python manage.py makemigrations && python manage.py migrate && python manage.py collectstatic"
# Создаем пользователя 
docker run -it nginx:serg-v1 sh # заходим в контейнер
python manage.py createsuperuser
```
# 3. Dockerfile для django контейнера:

```Bash
app/Dockerfile
# Сборка 
docker build -t django:v1 .
```

# 4. docker network
```bash

```
TODO Осталось:
1. разобраться с volume
2. подключить статику в контейнер с веб
3. подключить волюм в котейнер с приложением, забрать статику
> https://semaphoreci.com/community/tutorials/dockerizing-a-python-django-web-application
    > https://www.digitalocean.com/community/tutorials/how-to-build-a-django-and-gunicorn-application-with-docker