#!/bin/bash

echo "Opening tcp socke to ts3 server..."
exec  3<>/dev/tcp/192.168.88.155/10011 ;

echo "Send login credentials..."
echo -en "login serveradmin Pa$$w0rd\r\n" >&3 ;
#sleep 1;

echo "Set virtual server ID to 1"
echo -en "use sid=1\r\n" >&3 ;
#sleep 1;

echo "Get serverinfo from ts3 server..."
echo -en "serverinfo -uid 1 -all\r\n" >&3

echo "Quit connection..."
echo -en "quit\r\n" >&3 ;

echo "Display socket  content..."
cat <&3 |  grep -oE \
 -e 'virtualserver_maxclients=[0-9]{1,}' \
 -e 'virtualserver_clientsonline=[0-9]{1,}' \
 -e 'connection_bandwidth_sent_last_minute_total=[0-9]{1,}' \
 -e 'connection_bandwidth_received_last_minute_total=[0-9]{1,}' ;

exit
