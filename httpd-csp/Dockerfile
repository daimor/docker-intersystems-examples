FROM httpd:2.4

MAINTAINER Dmitry Maslennikov <mrdaimor@gmail.com>

COPY ./cspgateway/ /opt/cspgateway/bin

COPY httpd-csp.conf ./conf/extra

RUN echo "Include conf/extra/httpd-csp.conf" >> ./conf/httpd.conf \
 && mkdir -p /opt/cspgateway/csp \ 
 && chown -R www-data:www-data /opt/cspgateway \
 && chgrp -R www-data ./conf/extra/httpd-csp.conf
