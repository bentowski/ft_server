# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    test.sh                                            :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: pcoureau <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/03 18:22:25 by pcoureau          #+#    #+#              #
#    Updated: 2020/02/03 18:22:33 by pcoureau         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

service mysql start
echo "CREATE DATABASE testdb;" | mysql -u root
echo "CREATE USER 'testuser'@'localhost' IDENTIFIED BY 'testpw';" | mysql -u root
echo "GRANT USAGE ON *.* TO 'testuser'@'localhost' IDENTIFIED BY 'testpw';" | mysql -u root
echo "GRANT ALL privileges ON testdb.* TO 'testuser'@localhost;" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root
​
chown -R www-data:www-data /var/www/*
chmod -R 755 /var/www/html/example
​
service mysql restart
/etc/init.d/php7.3-fpm start
service nginx restart
bash
