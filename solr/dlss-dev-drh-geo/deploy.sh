#!/bin/bash
c=dlss-dev-drh-geo-201306
d=/home/drh/dlss-dev-drh-geo
n=3
cd $d/conf || exit -1

java -cp "/usr/share/tomcat6/webapps/solr/WEB-INF/lib/*" \
  org.apache.solr.cloud.ZkCLI -cmd upconfig -zkhost 127.0.0.1:2181 \
  -confdir . -confname $c \
  -solrhome /home/lyberadmin/solr-home

set -x
curl "http://127.0.0.1:8080/solr/admin/collections?action=DELETE&name=${c}"
sleep 5
curl "http://127.0.0.1:8080/solr/admin/collections?action=CREATE&name=${c}&numShards=1&replicationFactor=${n}"
