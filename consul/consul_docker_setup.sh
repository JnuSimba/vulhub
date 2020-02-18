#!/bin/sh

echo "[+] Launching consul instances..."
BOOTSTRAP_ID=`docker run -p8301:8301  -d --name=consul_bootstrap_server consul:1.0.7 agent -server -client=0.0.0.0 -bootstrap -data-dir /tmp/consul`
sleep 2
BOOTSTRAP_IP=`docker inspect --format '{{ .NetworkSettings.IPAddress }}' $BOOTSTRAP_ID`
docker run -d -p1998:8500 -v /tmp:/tmp --name=consul_client_1 -e 'CONSUL_LOCAL_CONFIG={"leave_on_terminate": true, "enable_script_checks":true, "disable_remote_exec":false}' consul:1.0.7 agent -ui -client=0.0.0.0 -retry-join=$BOOTSTRAP_IP
echo "[+] Checking members..."
docker exec -t consul_bootstrap_server consul members -http-addr="$BOOTSTRAP_IP:8500"
