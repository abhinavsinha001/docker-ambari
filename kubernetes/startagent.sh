#bin/bash
tail -F /var/log/ambari-agent/ambari-agent.log &
ambari-agent start
