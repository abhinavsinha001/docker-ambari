#bin/bash
tail -F /var/log/ambari-server/ambari-server.log &
ambari-server setup -s
ambari-server start
