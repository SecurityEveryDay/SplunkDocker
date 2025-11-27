#!/bin/bash

cat <<EOL >> /opt/splunk/etc/system/local/user-seed.conf
[user_info]
USERNAME=$SPLUNK_ADMIN
PASSWORD=$SPLUNK_ADMIN_PASSWORD
EOL

cat <<EOL >> /opt/splunk/etc/system/local/web.conf
[settings]
enableSplunkWebSSL = true

EOL

mkdir -p /opt/splunk/etc/apps/launcher/local/
cat <<EOL >> /opt/splunk/etc/apps/launcher/local/inputs.conf
[splunktcp://9997]
connection_host = ip

[http://default]
disabled = 0
host = local
token = $TOKEN_HEC

[udp://1514]
connection_host = ip
host = local
sourcetype = $SOURCETYPE_1514_UDP

[tcp://1514]
connection_host = ip
host = local
sourcetype = $SOURCETYPE_1514_TCP

[udp://1515]
connection_host = ip
host = local
sourcetype = $SOURCETYPE_1515_UDP

[tcp://1515]
connection_host = ip
host = local
sourcetype = $SOURCETYPE_1515_TCP

EOL

mkdir -p /opt/splunk/etc/apps/splunk_httpinput/local/

cat <<EOL >> /opt/splunk/etc/apps/splunk_httpinput/local/inputs.conf
[http]
disabled = 0
EOL


/opt/splunk/bin/splunk start --accept-license --answer-yes --no-prompt

#/opt/splunk/bin/splunk add user $ADMIN_USER -password $PASSWORD_ADMIN_USER -role admin -auth $SPLUNK_ADMIN:$SPLUNK_ADMIN_PASSWORD
/opt/splunk/bin/splunk add user $USER -password $PASSWORD_USER -role user -auth $SPLUNK_ADMIN:$SPLUNK_ADMIN_PASSWORD

while true;
do
    echo "Splunk working..."
    sleep 600
done
