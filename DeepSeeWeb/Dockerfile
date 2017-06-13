FROM daimor/intersystems-cache:2017.1

# version DeepSeeWeb
ARG DSW_VERSION=2.1.4

COPY cache.key /opt/ensemble/mgr/

COPY install.scr /tmp

COPY Installer.cls /tmp/deps/

# Temporary folder
RUN mkdir -p /tmp/deps \

 && cd /tmp/deps \

 # Download MDX2JSON, just master branch from github as archive
 && curl -L -q https://github.com/intersystems-ru/Cache-MDX2JSON/archive/master.tar.gz | tar xvfzC - . \

 # Download DeepSeeWeb from releases
 && curl -L -q https://github.com/intersystems-ru/DeepSeeWeb/releases/download/${DSW_VERSION}/DSW.Installer.${DSW_VERSION}.xml -o deepseeweb.xml \

 # Start Caché
 && ccontrol start $ISC_PACKAGE_INSTANCENAME \

 # add login and password for csession in our installer script
 && sed -i "1s/^/_SYSTEM\n$ISC_PACKAGE_USER_PASSWORD\n/" /tmp/install.scr \

 # run install script
 && csession $ISC_PACKAGE_INSTANCENAME < /tmp/install.scr \

 # Sstop Cache
 && ccontrol stop $ISC_PACKAGE_INSTANCENAME quietly \

 # clean temporary folder
 && rm -rf /tmp/deps

WORKDIR /opt/deepsee

