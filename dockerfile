FROM ubuntu:latest

# Install MySQL Server and utilities without interactive prompts
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server mysql-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Configure MySQL
ENV MYSQL_ROOT_PASSWORD=your_root_password
ENV MYSQL_DATABASE=your_database_name
ENV MYSQL_USER=your_username
ENV MYSQL_PASSWORD=your_password

# Install phpMyAdmin dependencies
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y apache2 php libapache2-mod-php php-mysql && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download and install phpMyAdmin
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y phpmyadmin && \
    ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Expose ports
EXPOSE 3306
EXPOSE 80

# CMD to start MySQL and Apache
CMD service mysql start && service apache2 start && tail -f /var/log/apache2/error.log
