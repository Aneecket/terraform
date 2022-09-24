variable "rules" {
  description = "Map of known security group rules (define as 'name' = ['from port', 'to port', 'protocol', 'description'])"
  type        = map(list(any))

  # Protocols (tcp, udp, icmp, all - are allowed keywords) or numbers
  # All = -1, IPV4-ICMP = 1, TCP = 6, UDP = 17, IPV6-ICMP = 58
  default = {
    # Cassandra
    cassandra-clients-tcp        = [9042, 9042, "tcp", "Cassandra clients"]
    cassandra-thrift-clients-tcp = [9160, 9160, "tcp", "Cassandra Thrift clients"]
    cassandra-jmx-tcp            = [7199, 7199, "tcp", "JMX"]

    # Elasticsearch
    elasticsearch-rest-tcp = [9200, 9200, "tcp", "Elasticsearch REST interface"]
    elasticsearch-java-tcp = [9300, 9300, "tcp", "Elasticsearch Java interface"]

    # Grafana
    grafana-tcp = [3000, 3000, "tcp", "Grafana Dashboard"]

    # HTTP
    http-80-tcp   = [80, 80, "tcp", "HTTP"]
    http-8080-tcp = [8080, 8080, "tcp", "HTTP"]
    # HTTPS
    https-443-tcp  = [443, 443, "tcp", "HTTPS"]
    https-8443-tcp = [8443, 8443, "tcp", "HTTPS"]

    #Emr custom
    https-9443-tcp = [9443, 9443, "tcp", "HTTPS"]

    # Kafka
    kafka-broker-tcp        = [9092, 9092, "tcp", "Kafka broker 0.8.2+"]
    kafka-broker-tls-tcp    = [9094, 9094, "tcp", "Kafka TLS enabled broker 0.8.2+"]
    kafka-jmx-exporter-tcp  = [11001, 11001, "tcp", "Kafka JMX Exporter"]
    kafka-node-exporter-tcp = [11002, 11002, "tcp", "Kafka Node Exporter"]

    # Kibana
    kibana-tcp = [5601, 5601, "tcp", "Kibana Web Interface"]

    # Kubernetes
    kubernetes-api-tcp = [6443, 6443, "tcp", "Kubernetes API Server"]

    # Logstash
    logstash-tcp = [5044, 5044, "tcp", "Logstash"]

    # MongoDB
    mongodb-27017-tcp = [27017, 27017, "tcp", "MongoDB"]
    mongodb-27018-tcp = [27018, 27018, "tcp", "MongoDB shard"]
    mongodb-27017-18-tcp = [27017, 27018, "tcp", "MongoDB"]
    mongodb-27019-tcp = [27019, 27019, "tcp", "MongoDB config server"]

    # MySQL
    mysql-tcp = [3306, 3306, "tcp", "MySQL/Aurora"]

    # postgresql
    postgresql-tcp = [5432, 5432, "tcp", "postgresql"]

    # Prometheus
    prometheus-http-tcp             = [9090, 9090, "tcp", "Prometheus"]
    prometheus-pushgateway-http-tcp = [9091, 9091, "tcp", "Prometheus Pushgateway"]
    blackbox-tcp = [9115, 9115, "tcp", "blackbox exporter"]


    # RDP
    rdp-tcp = [3389, 3389, "tcp", "Remote Desktop"]
    rdp-udp = [3389, 3389, "udp", "Remote Desktop"]

    # Redis
    redis-tcp = [6379, 6379, "tcp", "Redis"]

    # SSH
    ssh-tcp = [22, 22, "tcp", "SSH"]

    # Zookeeper
    zookeeper-2181-tcp = [2181, 2181, "tcp", "Zookeeper"]
    zookeeper-2182-tcp = [2182, 2182, "tcp", "Zookeeper"]
    zookeeper-2888-tcp = [2888, 2888, "tcp", "Zookeeper"]
    zookeeper-3888-tcp = [3888, 3888, "tcp", "Zookeeper"]
    zookeeper-jmx-tcp  = [7199, 7199, "tcp", "JMX"]

    #custom
    kafkadev-tcp = [8888, 8888, "tcp", "used in kafka dev"]
    nodeexp-tcp  = [9100, 9100, "tcp", "node exporter"]
    scyllarest-tcp  = [10000, 10000, "tcp", "scylla rest api"]
    scyllaprom-tcp  = [9180, 9180, "tcp", "scylla prometheus"]
    internode1-tcp  = [7001, 7001, "tcp", "internode communication1"]
    internode2-tcp  = [7000, 7000, "tcp", "internode communication2"]
    rpc-tcp  = [32080, 32080, "tcp", "rpc tags"]
    artifactory-tcp  = [8081, 8081, "tcp", "artifactory"]
    sonarqube-tcp  = [9000, 9000, "tcp", "sonarqube"]
    kafkaconnect-tcp  = [8083, 8083, "tcp", "kafka connect"]
    custom1-tcp  = [32443, 32443, "tcp", "custom within vpc"]
    custom2-tcp  = [20000, 20000, "tcp", "custom within vpc"]
    custom3-udp  = [53, 53, "udp", "core dns"]
    custom4-tcp  = [50000, 50000, "tcp", "custom within vpc"]
    custom5-tcp  = [31090, 31092, "tcp", "custom within vpc"]
    custom6-udp  = [30053, 30053, "udp", "core dns"]
    custom7-tcp  = [30900, 30900, "tcp", "custom within vpc"]
    custom8-tcp  = [8085, 8085, "tcp", "cluster autoscaler"]
    custom9-tcp  = [10254, 10254, "tcp", "nginx metric"]
    custom10-tcp  = [9153, 9153, "tcp", "core dns metric"]
    custom11-tcp  = [31000, 31000, "tcp", "mocker port"]
    custom12-tcp  = [10250, 10250, "tcp", "nginx metric"]
    custom13-tcp  = [1025, 65535, "tcp", "master traffic"]
    custom14-tcp  = [10020, 10020, "tcp", "custom within vpc"]
    custom15-tcp  = [9870, 9870, "tcp", "custom within vpc"]
    custom16-tcp  = [19888, 19888, "tcp", "custom within vpc"]
    custom17-tcp  = [8088, 8088, "tcp", "custom within vpc"]
    custom18-tcp  = [0, 0, "tcp", "custom within vpc"]
    custom19-tcp  = [4446, 4446, "tcp", "custom within vpc"]
    custom20-tcp  = [9864, 9864, "tcp", "custom within vpc"]
    custom21-tcp  = [8042, 8042, "tcp", "custom within vpc"]
    custom22-tcp  = [20888, 20888, "tcp", "custom within vpc"]
    custom23-tcp  = [53, 53, "tcp", "core dns"]
    custom24-icmp  = [3, 4, "icmp", "custom"]
    custom25-tcp  = [4141, 4141, "tcp", "custom"]


    # Open all ports & protocols
    all-all       = [-1, -1, "-1", "All protocols"]
    all-tcp       = [0, 65535, "tcp", "All TCP ports"]
    all-udp       = [0, 65535, "udp", "All UDP ports"]
    all-icmp      = [-1, -1, "icmp", "All IPV4 ICMP"]
    all-ipv6-icmp = [-1, -1, 58, "All IPV6 ICMP"]
    # This is a fallback rule to pass to lookup() as default. It does not open anything, because it should never be used.
    _ = ["", "", ""]
  }
}
