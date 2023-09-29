FROM ubuntu:latest

RUN apt update && apt upgrade -y && apt  install -y php php-tcpdf php-cgi php-pear php-mbstring libapache2-mod-php php-common php-phpseclib php-mysql && apt install mariadb-server && apt -y install apache2 && apt install wget && apt install nano

RUN wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz
RUN tar xvf phpMyAdmin-latest-all-languages.tar.gz
RUN mv phpMyAdmin-*/ /usr/share/phpmyadmin
RUN mkdir -p /var/lib/phpmyadmin/tmp
RUN chown -R www-data:www-data /var/lib/phpmyadmin
RUN mkdir /etc/phpmyadmin/
RUN cp /usr/share/phpmyadmin/config.sample.inc.php  /usr/share/phpmyadmin/config.inc.php
# Expose ports
EXPOSE 3306
EXPOSE 80

# CMD to start MySQL and Apache
CMD service mysql start && service apache2 start && tail -f /var/log/apache2/error.log
