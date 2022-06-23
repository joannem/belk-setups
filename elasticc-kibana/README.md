**Running Elastic-Kibana Cluster**

1. Run docker files
	```
	sysctl -w vm.max_map_count=262144
	docker compose up -d
	```
2. Verify that Elastic is up
	```
	$ sudo curl --cacert /var/lib/docker/volumes/elasticc-kibana_certs/_data/ca/ca.crt -u elastic https://localhost:9200
	Enter host password for user 'elastic':
	{
	  "name" : "es01",
	  "cluster_name" : "docker-cluster",
	  "cluster_uuid" : "Q21Vi1V8TkuI86DRqN0iHQ",
	  "version" : {
	    "number" : "8.2.3",
	    "build_flavor" : "default",
	    "build_type" : "docker",
	    "build_hash" : "9905bfb62a3f0b044948376b4f607f70a8a151b4",
	    "build_date" : "2022-06-08T22:21:36.455508792Z",
	    "build_snapshot" : false,
	    "lucene_version" : "9.1.0",
	    "minimum_wire_compatibility_version" : "7.17.0",
	    "minimum_index_compatibility_version" : "7.0.0"
	  },
	  "tagline" : "You Know, for Search"
	}

	```
3. Verify that Kibana is up at https://localhost:5601/, and log in with user: elastic, password: password

**Clean-up**
```
docker copose down -v
```
