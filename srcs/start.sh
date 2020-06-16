# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    start.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: pcoureau <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/06 16:12:38 by pcoureau          #+#    #+#              #
#    Updated: 2020/02/06 16:38:12 by pcoureau         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# LAUNCH SERVICES

service mysql start

echo "CREATE DATABASE wordpress;" | mysql -u root
echo "CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';" | mysql -u root
echo "GRANT USAGE ON *.* TO 'admin'@'localhost' IDENTIFIED BY 'admin';" | mysql -u root
echo "GRANT ALL privileges ON *.* TO 'admin'@localhost;" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root

service nginx restart
service mysql restart
service php7.3-fpm restart

bash

