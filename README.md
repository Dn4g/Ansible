# Ansible - практическая работа
+ **main.tf** - конфиг Терраформа по работе с Яндекс.Облаком. Создаёт три сервера согласно заданию, создаёт юзера Ansible с ключом на всех серверах.

+ **setup_node.yml** - настраивает удалённую ноду Ansible, копирует hosts, зашифрованный приватный ключ, плейбук.

+ **node_postgres_docker.yml** - выполняется на Ansible-ноде, ставит PostgreSQL указанной версии и меняет дата-директорию локально и ставит Docker на других серверах.

+ **host** - описание групп и переменных.

В целом, инфраструктура выглядит так:

![ну, как смог ](https://dn4g.ru/image.jpg)

