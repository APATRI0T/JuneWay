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
Зарегистрироваться в Google Cloud Platform
## 1.1 Установка docker в centos8:
```Bash
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce docker-ce-cli containerd.io
sudo systemctl start docker
sudo usermod -aG docker ${USER}
su - ${USER}

cd /srv/
git clone github.com:APATRI0T/JuneWay.git
```


# 3. Dockerfile для django контейнера:

```Bash
# Сборка 
docker build -t django:v1 .

```
> https://semaphoreci.com/community/tutorials/dockerizing-a-python-django-web-application
    > https://www.digitalocean.com/community/tutorials/how-to-build-a-django-and-gunicorn-application-with-docker