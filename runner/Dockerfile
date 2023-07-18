FROM ubuntu:22.04

RUN apt update && apt install -y mysql-client cron
COPY ./mysql_cluster_setup.sh /opt/mysql/mysql_cluster_setup.sh
COPY ./mysql_backup.sh /opt/mysql/mysql_backup.sh
RUN echo '* 1 * * * /opt/mysql/mysql_backup.sh > /dev/stdout' >> /etc/crontab
RUN chmod +x /opt/mysql/mysql_cluster_setup.sh
RUN chmod +x /opt/mysql/mysql_backup.sh
RUN service cron start