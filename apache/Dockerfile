FROM httpd:stable

COPY ./sites-available /etc/apache2/sites-available
RUN ln -s /etc/apache2/sites-available/apache_server1.conf /etc/apache2/sites-enabled/apache_server1.conf
RUN ln -s /etc/apache2/sites-available/apache_server2.conf /etc/apache2/sites-enabled/apache_server2.conf
RUN ln -s /etc/apache2/sites-available/apache_server3.conf /etc/apache2/sites-enabled/apache_server3.conf