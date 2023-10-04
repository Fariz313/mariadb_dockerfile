FROM ubuntu:20.04
RUN apt-get update && apt-get install -y mariadb-server phpmyadmin php-mbstring php-xml php-gd php-curl apache2
RUN service mariadb start
RUN mysql -u root -p"" -e "CREATE DATABASE IF NOT EXISTS my_database;"
RUN mysql -u root -p"" -e "CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';"
RUN mysql -u root -p"" -e "GRANT ALL PRIVILEGES ON my_database.* TO 'admin'@'localhost';"
RUN mysql -u root -p"" -e "FLUSH PRIVILEGES;"
# create config.inc.php
RUN echo "<?php" > /etc/phpmyadmin/config.inc.php
RUN echo "$cfg['Servers'][$i]['host'] = 'localhost';" >> /etc/phpmyadmin/config.inc.php
RUN echo "$cfg['Servers'][$i]['port'] = '3306';" >> /etc/phpmyadmin/config.inc.php
RUN echo "$cfg['Servers'][$i]['user'] = 'admin';" >> /etc/phpmyadmin/config.inc.php
RUN echo "$cfg['Servers'][$i]['password'] = 'admin';" >> /etc/phpmyadmin/config.inc.php
RUN echo "$cfg['Servers'][$i]['database'] = 'my_database';" >> /etc/phpmyadmin/config.inc.php
RUN echo "?>" >> /etc/phpmyadmin/config.inc.php
# create .my.cnf
RUN echo "[client]" > /root/.my.cnf
RUN echo "user=admin" >> /root/.my.cnf
RUN echo "password=admin" >> /root/.my.cnf
# create .bashrc
RUN echo "export MYSQL_PWD=admin" >> /root/.bashrc
EXPOSE 80 443 3306
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
CMD ["service", "apache2", "start"]