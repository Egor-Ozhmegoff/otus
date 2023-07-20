bash /opt/mysql/mysql_cluster_setup.sh >> /var/log/mysql_config.log 2>&1
cron
sleep infinity
eval `ssh-agent -s`
ssh-add /root/.ssh/otus
git clone git clone git@github.com:Egor-Ozhmegoff/backup.git /opt/mysql