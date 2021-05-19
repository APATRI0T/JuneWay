# Juneway Less 1.9
    Описание задания
    1. Создать пользователя, назвать как нравится. Разрешить ему выполнять через sudo только одну программу (skukozh из вложения)
    2. Выставить атрибуты на skukozh:
    - владелец: чтение, исполнение
    - группа: чтение, исполнение
    - мир: -
    3. Скопировать любой исполняемый файл (ls, bash, итд) в домашний каталог пользователя.
    Скукожить этот исполняемый файл, и убедиться, что он не работает ($ sudo skukozh ./bash , например).

    Будьте осторожны, и не скукожьте чего-то не то.
# Решение
```bash
# 1. создание пользователя
sudo useradd -m  -s /bin/bash juneway
echo "111" | passwd --stdin juneway
# добавляем sudoers
echo "juneway ALL=/home/juneway/skukozh" > /etc/sudoers.d/juneway

# логинимся в нового пользователя и копируем файлик из задания
su - juneway
cp /srv/JuneWay/less1.9/skukozh ./

# 2. права u:r-x,g:r-x,o:-
chmod 550 skukozh  

# 3. скукоживаем
cp /bin/ls ~/
./skukozh ./ls
juneway@juneway:~$ ./ls
# >>> bash: ./ls: cannot execute binary file: Exec format error

# проверяем sudo: все работает
juneway@juneway:/root$ sudo /home/juneway/skukozh
# >>> usage: /home/juneway/skukozh file

```