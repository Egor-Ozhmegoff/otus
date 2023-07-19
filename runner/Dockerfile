FROM ubuntu:22.04

RUN apt update && apt install -y mysql-client cron nano
COPY ./initial_script.sh /opt/initial_script.sh
COPY ./mysql_cluster_setup.sh /opt/mysql/mysql_cluster_setup.sh
COPY ./mysql_backup.sh /opt/mysql/mysql_backup.sh
RUN echo 'SHELL=/bin/bash' >> /etc/cron.d/backup_job
RUN echo '* * * * * root /opt/mysql/mysql_backup.sh >> /var/log/cron.log 2>&1' >> /etc/cron.d/backup_job
RUN chmod +x /opt/initial_script.sh
RUN chmod +x /opt/mysql/mysql_cluster_setup.sh
RUN chmod +x /opt/mysql/mysql_backup.sh