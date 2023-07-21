# otus
В данном проекте используется докер для развертки сервисов,
сервисы разделены по папкам alertmanager, grafana,mysql,nginx,prometheus.

В каждой папке находятся настройки для конкретного сервиса.

+ daemon.json - настройки логирования для докера
+ docker-compose.yaml инструкции для поднятия сервисов
+ docker_install.sh вспомогательный скрипт для установки докера
+ mysq_master_confin.sh скрипт для настройки мастера
+ mysq_slave_config.sh скрипт для настройки репликации слейва
+ mysql/mysql_backup.sh скрипт для бэкапа базы wordpress

Для хранения бэкапов используется отдельный репозирорий
https://github.com/Egor-Ozhmegoff/backup
