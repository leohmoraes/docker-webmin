# Supervisord, Python, webmin
#
# VERSION               0.0.1
#

FROM     ubuntu:trusty
MAINTAINER Jonas Colmsjö "jonas@gizur.com"

RUN echo "export HOME=/root" >> /root/.profile

# Mirros: http://ftp.acc.umu.se/ubuntu/ http://us.archive.ubuntu.com/ubuntu/
RUN echo "deb http://ftp.acc.umu.se/ubuntu/ trusty-updates main restricted" >> /etc/apt/source.list

RUN apt-get update
RUN apt-get install -y wget nano curl git


#
# Install supervisord (used to handle processes)
# ----------------------------------------------
#
# Installation with easy_install is more reliable. apt-get don't always work.

RUN apt-get install -y python python-setuptools
RUN easy_install supervisor

ADD ./etc-supervisord.conf /etc/supervisord.conf
ADD ./etc-supervisor-conf.d-supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN mkdir -p /var/log/supervisor/


#
# Install Apache
# ---------------

#RUN apt-get install -y apache2 php5 php5-mcrypt
#RUN a2enmod rewrite status
#ADD ./etc-apache2-apache2.conf /etc/apache2/apache2.conf

#RUN rm /var/www/html/index.html
#RUN echo "<?php\nphpinfo();\n " > /var/www/html/info.php


#
# Install rsyslog
# ---------------

RUN apt-get install -y rsyslog
ADD ./etc-rsyslog.conf /etc/rsyslog.conf


#
# Install webmin
# ---------------


RUN apt-get install -y libauthen-pam-perl
ADD ./webmin-1.740.tar.gz /
ADD ./install.sh /
RUN /install.sh


EXPOSE 80 443
CMD ["supervisord"]
