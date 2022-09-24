variable "cluster_name" {
  description = "Name of the MSK cluster."
  type        = string
}

variable "az_distribution" {
  description = "AZ distribution"
  type        = string
  default     = "DEFAULT"
}

variable "config_info_arn" {
  description = "Configuration info arn"
  type        = string
}


variable "config_info_revision" {
  description = "Configuration info arn revision"
  type        = string
  default     = "1"
}


variable "kafka_version" {
  description = "Specify the desired Kafka software version."
  type        = string
  default     = ""
}

variable "number_of_broker_nodes" {
  description = "The desired total number of broker nodes in the kafka cluster. It must be a multiple of the number of specified client subnets."
  type        = number
}

variable "client_subnets" {
  description = "A list of subnets to connect to in client VPC"
  type        = list(string)
}

variable "ebs_volume_size" {
  description = "The size in GiB of the EBS volume for the data drive on each broker node."
  type        = number
  default     = 1000
}

variable "instance_type" {
  description = "Specify the instance type to use for the kafka brokers. e.g. kafka.m5.large."
  type        = string
}

variable "security_groups" {
  description = "A list of extra security groups to associate with the elastic network interfaces to control who can communicate with the cluster."
  type        = list(string)
  default     = []
}

variable "enhanced_monitoring" {
  description = "Specify the desired enhanced MSK CloudWatch monitoring level to one of three monitoring levels: DEFAULT, PER_BROKER, PER_TOPIC_PER_BROKER or PER_TOPIC_PER_PARTITION. See [Monitoring Amazon MSK with Amazon CloudWatch](https://docs.aws.amazon.com/msk/latest/developerguide/monitoring.html)."
  type        = string
  default     = "DEFAULT"
}

variable "enable_cloudwatch_logs" {
  description = "Indicates whether you want to enable or Cloudwatch logs or not."
  type        = string
  default     = "false"
}

variable "cloudwatch_log_group" {
  description = "Location of the cloudwatch_log_group"
  type        = string
  default     = "false"
}

variable "enable_jmx_exporter_broker" {
  description = "Indicates whether you want to enable or disable the JMX Exporter."
  type        = string
  default     = "false"
}

variable "enable_node_exporter_broker" {
  description = "Indicates whether you want to enable or disable the Node Exporter."
  type        = string
  default     = "false"
}


variable "encryption_at_rest_kms_key_arn" {
  description = "You may specify a KMS key short ID or ARN (it will always output an ARN) to use for encrypting your data at rest. If no key is specified, an AWS managed KMS ('aws/msk' managed service) key will be used for encrypting the data at rest."
  type        = string
  default     = ""
}

variable "encryption_tranist_client_broker" {
  description = "Encryption setting for data in transit between clients and brokers. Valid values: TLS, TLS_PLAINTEXT, and PLAINTEXT. Default value is TLS_PLAINTEXT."
  type        = string
  default     = "TLS_PLAINTEXT"
}

variable "encryption_tranist_cluster" {
  description = "Whether data communication among broker nodes is encrypted. Default value: true."
  type        = bool
  default     = true
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "bucket_name" {
  description = "Name of the S3 bucket to deliver logs to."
  type        = string
  default     = ""
}

variable "enable_bucket" {
  description = "Enable/disable bucket logging"
  type        = string
  default     = "false"
}

variable "bucket_prefix" {
  description = "Prefix to append to the folder name."
  type        = string
  default     = ""
}

# variable "cloudwatch_logs_group" {
#   description = "Name of the Cloudwatch Log Group to deliver logs to."
#   type        = string
#   default     = ""
# }

variable "enable_firehose" {
  description = "Name of the Kinesis Data Firehose delivery stream to deliver logs to."
  type        = string
  default     = "false"
}
