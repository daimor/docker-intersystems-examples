FROM daimor/intersystems-ensemble

# Version of WebTerminal to install
ARG TerminalVersion=4.2.14

# Create temporary folder
RUN mkdir /tmp/webterminal \

 # Download installation xml from github
 && curl http://intersystems-ru.github.io/webterminal/files/WebTerminal-v$TerminalVersion.xml -o /tmp/webterminal/webterminal.xml \

 # Start Caché Instance
 && ccontrol start $ISC_PACKAGE_INSTANCENAME \

 # Generate login and password for csession if needed, and Load downloaded xml with compilation
 # WebTerminal will be installed during compilation process
 && printf "_SYSTEM\n$ISC_PACKAGE_USER_PASSWORD\n" \
 |  csession $ISC_PACKAGE_INSTANCENAME -UUSER "##class(%SYSTEM.OBJ).Load(\"/tmp/webterminal/webterminal.xml\",\"cdk\")" \

 # Stop Caché instance
 && ccontrol stop $ISC_PACKAGE_INSTANCENAME quietly  \

 # Clean Temporary folder
 && rm -rf /tmp/webterminal/