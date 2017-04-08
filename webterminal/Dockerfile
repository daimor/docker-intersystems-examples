FROM daimor/intersystems-ensemble

ARG TerminalVersion=4.2.14

RUN mkdir /tmp/webterminal \
 && curl http://intersystems-ru.github.io/webterminal/files/WebTerminal-v$TerminalVersion.xml -o /tmp/webterminal/webterminal.xml \
 && ccontrol start $ISC_PACKAGE_INSTANCENAME \
 && printf "_SYSTEM\n$ISC_PACKAGE_USER_PASSWORD\n" \
 |  csession $ISC_PACKAGE_INSTANCENAME -UUSER "##class(%SYSTEM.OBJ).Load(\"/tmp/webterminal/webterminal.xml\",\"cdk\")" \
 && ccontrol stop $ISC_PACKAGE_INSTANCENAME quietly \ 
 && rm -rf /tmp/webterminal/