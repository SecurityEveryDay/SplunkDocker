#!/bin/bash

cat <<EOL >> /opt/splunk/etc/system/local/user-seed.conf
[user_info]
USERNAME=$SPLUNK_USER
PASSWORD=$SPLUNK_PASSWORD
EOL

cat <<EOL >> /opt/splunk/etc/system/local/web.conf
[settings]
enableSplunkWebSSL = true
EOL

/opt/splunk/bin/splunk start --accept-license --answer-yes --no-prompt

while true;
do
    echo "Splunk working..."
    sleep 600

done