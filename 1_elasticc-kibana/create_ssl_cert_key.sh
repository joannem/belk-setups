#!/bin/bash

if [ "$#" -ne 1 ]; then
	echo "Usage $0 [hostname]"
	exit 1
fi

docker exec 1_elasticc-kibana-es01-1 \
	./bin/elasticsearch-certutil cert --name ${1} \
	--ca-cert config/certs/ca/ca.crt --ca-key config/certs/ca/ca.key \
	--dns ${1},localhost --ip 127.0.0.1 --pem -out ${1}-certs.zip && \

docker cp 1_elasticc-kibana-es01-1:/usr/share/elasticsearch/${1}-certs.zip .

unzip ${1}-certs.zip && mv ${1} ${1}-certs/
openssl pkcs8 -inform PEM -in ${1}-certs/${1}.key -topk8 -nocrypt -outform PEM -out ${1}-certs/${1}.pkcs8.key

## Clean up
rm -rf ${1}-certs.zip
docker exec 1_elasticc-kibana-es01-1 rm ${1}-certs.zip
