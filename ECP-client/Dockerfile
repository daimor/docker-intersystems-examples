# version 0.0.1

### Cache ###
FROM tutum/centos:latest

MAINTAINER Dmitry Maslennikov <mrdaimor@gmail.com>

# update OS + dependencies & run Caché silent instal
RUN yum -y update && yum -y install which tar hostname net-tools httpd && yum -y clean all &&\
    ln -sf /etc/locatime /usr/share/zoneinfo/Europe/Moscow

ARG globals8k=256
ARG routines=64
ARG locksiz
ARG gmheap

ENV TMP_INSTALL_DIR=/tmp/distrib

# vars for Caché silent install
ENV ISC_PACKAGE_INSTANCENAME="CACHE" \
    ISC_PACKAGE_INSTALLDIR="/usr/cachesys" \
    ISC_PACKAGE_UNICODE="Y" \
    ISC_PACKAGE_CSP_GATEWAY_DIR="/opt/cspgateway/" \
    ISC_PACKAGE_CSP_CONFIGURE="Y" \
    ISC_PACKAGE_CSP_SERVERTYPE="Apache" \
    ISC_PACKAGE_CSP_APACHE_VERSION=2.4

# vars for install our application     
ENV ISC_INSTALLER_MANIFEST=${TMP_INSTALL_DIR}/MyApp.ECPClientInstaller.cls \
    ISC_INSTALLER_LOGLEVEL=3 \
    ISC_INSTALLER_PARAMETERS="routines=$routines,locksiz=$locksiz,gmheap=$gmheap,globals8k=$globals8k"

# set-up and install Caché from distrib_tmp dir 
RUN mkdir ${TMP_INSTALL_DIR}
WORKDIR ${TMP_INSTALL_DIR}

# cache distributive
ADD cache-2016.2.0.623.0-lnxrhx64.tar.gz .

# our application installer
ADD MyApp.ECPClientInstaller.cls .

RUN mkdir /opt/myapp/ && \
	env | grep ISC_ && \ 
    ./cache-2016.2.0.623.0-lnxrhx64/cinstall_silent && \
    cat $ISC_PACKAGE_INSTALLDIR/mgr/cconsole.log && \
	rm -rf ${TMP_INSTALL_DIR}

# license file
ADD cache.key $ISC_PACKAGE_INSTALLDIR/mgr/
ADD mod_csp.conf /etc/httpd/conf.d/
RUN ccontrol stop $ISC_PACKAGE_INSTANCENAME quietly 

# TCP sockets that can be accessed if user wants to (see 'docker run -p' flag)
EXPOSE 80 57772 1972 22

# Caché container main process PID 1 (https://github.com/zrml/ccontainermain)
WORKDIR /
ADD ccontainermain .
ADD httpd.sh .
RUN cp run.sh sshd.sh && chmod a+x httpd.sh

ENTRYPOINT ["/ccontainermain", "-cconsole", "-xstart=/httpd.sh"]

