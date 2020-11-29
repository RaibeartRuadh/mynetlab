### Дано

https://github.com/erlong15/otus-linux/tree/network
(ветка network)

Vagrantfile с начальным построением сети

- inetRouter
- centralRouter
- centralServer

тестировалось на virtualbox

### Планируемая архитектура

Построить следующую архитектуру:

1.  Сеть office1
    - 192.168.2.0/26 - dev
    - 192.168.2.64/26 - test servers
    - 192.168.2.128/26 - managers
    - 192.168.2.192/26 - office hardware

2.  Сеть office2
    - 192.168.1.0/25 - dev
    - 192.168.1.128/26 - test servers
    - 192.168.1.192/26 - office hardware

3.  Сеть central
    - 192.168.0.0/28 - directors
    - 192.168.0.32/28 - office hardware
    - 192.168.0.64/26 - wifi

```
Office1 ---\
            -----> Central --> IRouter --> internet
Office2----/
```
Итого должны получится следующие сервера:

- inetRouter
- centralRouter
- office1Router
- office2Router
- centralServer
- office1Server
- office2Server

### Теоретическая часть

- Найти свободные подсети
- Посчитать сколько узлов в каждой подсети, включая свободные
- Указать broadcast адрес для каждой подсети
- проверить нет ли ошибок при разбиении

### Практическая часть

- Соединить офисы в сеть согласно схеме и настроить роутинг
- Все сервера и роутеры должны ходить в инет черз inetRouter
- Все сервера должны видеть друг друга
- у всех новых серверов отключить дефолт на нат (eth0), который вагрант поднимает для связи
- при нехватке сетевых интервейсов добавить по несколько адресов на интерфейс

Выполнение:
---------------

-- Запуск стенда:
    $ vagrant up

-- Схема:
https://github.com/RaibeartRuadh/mynetlab/blob/main/scheme.png

-- Теоретическая часть:

https://github.com/RaibeartRuadh/mynetlab/blob/main/network.ods
