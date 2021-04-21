# JuneWay task4
> Необходимо собрать nginx из исходников со стандартными модулями и > запустить бинарник во втором образе.
> Образы Debian9
> При запуске примаунтить конфиг в контейнер.
> https://www.thegeekstuff.com/2011/07/install-nginx-from-source/  
> https://docs.docker.com/develop/develop-images/multistage-build/  
> https://docs.docker.com/storage/bind-mounts/
> 
> Задача для прохождения на 100% (выполнять не обязательно)
> Добавить в сборку
> https://github.com/openresty/lua-nginx-module
> 
> 
> В ответе dockerfile в gitlab как отдельный проект

# Решение
```Bash
docker build -t nginx:task4-v3 .
./nginx-run.sh
 ```
