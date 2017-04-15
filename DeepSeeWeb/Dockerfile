FROM daimor/intersystems-ensemble:latest

# version DeepSeeWeb
ARG DSW_VERSION=2.0.22

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
 && ccontrol start ensemble \

 # add login and password for csession in our installer script
 && sed -i "1s/^/_SYSTEM\n$ISC_PACKAGE_USER_PASSWORD\n/" /tmp/install.scr \

 # run install script
 && csession ensemble < /tmp/install.scr \

 # Sstop Cache
 && ccontrol stop ensemble quietly \

 # clean temporary folder
 && rm -rf /tmp/deps

WORKDIR /opt/deepsee

