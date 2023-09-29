
FROM mariadb:latest

ENV MYSQL_ROOT_PASSWORD=your_root_password
ENV MYSQL_DATABASE=your_database_name
ENV MYSQL_USER=your_username
ENV MYSQL_PASSWORD=your_password

EXPOSE 3310

CMD ["mysqld", "--port=3310"]
