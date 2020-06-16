# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: pcoureau <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/06 15:49:32 by pcoureau          #+#    #+#              #
#                                                                              #
# **************************************************************************** #

#INSTALLATIONS
FROM debian:buster
COPY	./srcs/start.sh ./
COPY	./srcs/ ./srcs/
RUN		apt-get update 
RUN  	apt-get upgrade -y && apt-get -y install wget nginx mariadb-server mariadb-client && apt-get -y install php7.3-fpm php7.3-mysql php-mbstring php-zip && apt-get clean
#NGINX
RUN		mkdir -p /var/www/localhost
COPY	/srcs/nginx.conf /etc/nginx/sites-available/localhost
RUN		ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/localhost
#PHP
RUN		service php7.3-fpm start
#SSL
RUN		mkdir ~/mkcert && cd ~/mkcert && wget https://github.com/FiloSottile/mkcert/releases/download/v1.4.1/mkcert-v1.4.1-linux-amd64 && mv mkcert-v1.4.1-linux-amd64 mkcert && chmod 755 mkcert && ./mkcert -install && ./mkcert localhost
#WORDPRESS
COPY	srcs/wordpress-5.3.2.tar.gz ./
RUN		mkdir -p /var/www/localhost/wordpress && tar -zxvf wordpress-5.3.2.tar.gz --strip-components=1 -C /var/www/localhost/wordpress && chown -R www-data:www-data /var/www/localhost/wordpress && chmod 755 -R /var/www/localhost/wordpress/
#Installation de wordpress et parametrage de phpmyadmin (user : admin, mdp : admin)
COPY	/srcs/wp-config.php /var/www/localhost/wordpress
#PHPMYADMIN
RUN		mkdir -p /var/www/localhost/phpmyadmin && wget https://files.phpmyadmin.net/phpMyAdmin/4.9.4/phpMyAdmin-4.9.4-all-languages.tar.gz && tar -zxvf phpMyAdmin-4.9.4-all-languages.tar.gz --strip-components=1 -C /var/www/localhost/phpmyadmin && mkdir -p /var/www/localhost/phpmyadmin/tmp && chown -R www-data:www-data /var/www/localhost/phpmyadmin
#à voir si je peux pas virer cette ligne
COPY	/srcs/config.inc.php /var/www/localhost/phpmyadmin/
COPY	/srcs/index.php /var/www/localhost/index.php
COPY	/srcs/info.php /var/www/localhost/

#to build the docker : docker build -t docker .
#to run the docker : docker run -p 80:80 -p 443:443 -ti docker
CMD		bash start.sh