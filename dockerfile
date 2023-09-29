FROM mariadb:latest

# Install phpMyAdmin dependencies
RUN apt-get update && \
    apt-get install -y apache2 php libapache2-mod-php php-mysql

# Configure MariaDB
ENV MYSQL_ROOT_PASSWORD=your_root_password
ENV MYSQL_DATABASE=your_database_name
ENV MYSQL_USER=your_username
ENV MYSQL_PASSWORD=your_password

# Move phpMyAdmin to a directory accessible by the web server
RUN mv /usr/share/phpmyadmin /var/www/html/phpmyadmin

# Expose ports
EXPOSE 3306
EXPOSE 80
