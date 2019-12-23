#bin/bash
tail -F /var/log/ambari-server/ambari-server.log &
ambari-server start
