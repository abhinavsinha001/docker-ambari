#bin/bash
tail -F /var/log/ambari-agent/ambari-agent.log &
sed -i 's/verify=platform_default/verify=disable/' /etc/python/cert-verification.cfg
sed -i "s,^hostname=.*$,hostname=$AMBARI_SERVER," /etc/ambari-agent/conf/ambari-agent.ini
ambari-agent start
