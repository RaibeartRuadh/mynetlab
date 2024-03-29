# Для проверки работы вам потребуется установить:
- Ansible 2.9.6
- Oracle VirtualBox 6.0
- Vagrant Vagrant 2.2.19

Если по команде vagrant up из основной директории проекта выдает ошибку образа, требуется скачать и установить образ, аналогичный Centos 7 -  https://app.vagrantup.com/centos/boxes/7
Также трубется заменить название образа, которое вы указали при загрузке (команда vagrant box add --name ИМЯ_ОБРАЗА URL or Address to Image) в файле Vagrantfile проекта.

      Vagrant.configure("2") do |config|
         config.vm.box = "ИМЯ_ОБРАЗА"

------------------------------------------------------------

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
![План сети](https://github.com/RaibeartRuadh/mynetlab/blob/main/networkplan.png)

-- Теоретическая часть:
    
 ![Табличка](https://github.com/RaibeartRuadh/mynetlab/blob/main/network.png) 
