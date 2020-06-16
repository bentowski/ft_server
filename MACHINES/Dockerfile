# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: pcoureau <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/04 16:51:55 by pcoureau          #+#    #+#              #
#    Updated: 2020/02/06 14:43:24 by pcoureau         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster
COPY /srcs/test.sh ./

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y nginx
RUN chown www-data:www-data /usr/share/nginx/html/ -R
RUN apt-get install -y mariadb-server mariadb-client
RUN apt install -y php7.3 php7.3-fpm php7.3-mysql php-common php7.3-cli php7.3-common php7.3-json php7.3-opcache php7.3-readline

#mysql
RUN service mysql start

#php
RUN service php7.3-fpm start
COPY srcs/info.php /usr/share/nginx/html/

#nginx
RUN rm /etc/nginx/sites-enabled/default
COPY srcs/default.conf /etc/nginx/conf.d/

CMD bash test.sh

