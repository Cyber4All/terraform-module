# --------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# --------------------------------------------------------

variable "service_name" {
  type        = string
  description = "Name that will associate all resources."
}

# ----------------------------------------------------
# service discovery parameters
# ----------------------------------------------------
variable "dns_namespace_id" {
  type        = string
  description = "The ID of the namespace to use for DNS configuration."
}

# ----------------------------------------------------
# ecs task-definition parameters
# ----------------------------------------------------

variable "image" {
  type        = string
  description = "The image used to start a container. This string is passed directly to the Docker daemon. Images in the Docker Hub registry are available by default. You can also specify other repositories with either `repository-url/image:tag` or `repository-url/image@digest`. Up to 255 letters (uppercase and lowercase), numbers, hyphens, underscores, colons, periods, forward slashes, and number signs are allowed."
}

# ----------------------------------------------------
# ecs service parameters
# ----------------------------------------------------
variable "cluster_arn" {
  type        = string
  description = "ARN of an ECS cluster."
}

variable "desired_count" {
  type        = number
  description = "Number of instances of the task definition to place and keep running. Defaults to 1. Do not specify if using the `DAEMON` scheduling strategy."
  default     = 1
}

# --------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# --------------------------------------------------------

# ----------------------------------------------------
# service discovery parameters
# ----------------------------------------------------
variable "service_discovery_description" {
  type        = string
  description = "The description of the service."
  default     = "Service Discovery Managed by Terraform"
}

# ----------------------------------------------------
# ecs task-definition parameters
# ----------------------------------------------------

variable "container_cpu" {
  type        = number
  description = "The hard limit of CPU units to present for the task. For tasks that use the Fargate launch type (both Linux and Windows containers), this field is required. "
  default     = 256
}

variable "container_memory" {
  type        = number
  description = "The amount (in MiB) of memory to present to the container. [container_definition_memory](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#container_definition_memory)"
  default     = 256
}

variable "container_port" {
  type        = number
  description = "The port number on the container that's bound to the user-specified or automatically assigned host port."
  default     = null
}

variable "port_mappings" {
  type        = list(any)
  description = "Port mappings allow containers to access ports on the host container instance to send or receive traffic. For task definitions that use the `awsvpc` network mode, only specify the containerPort. The `hostPort` can be left blank or it must be the same value as the `containerPort`. Consists (containerPort, hostPort, protocol)"
  default     = []
}

variable "disable_service_discovery" {
  type        = bool
  description = "Set to true if service discovery should not be configured. Otherwise either set the service_registries block or provide values for service_name, and container_port."
  default     = false
}

variable "environment" {
  type        = list(any)
  description = "The environment variables to pass to a container. This parameter maps to the --env option to docker run. Consists (name, value)"
  default     = []
}

variable "environment_files" {
  type        = list(any)
  description = "A list of files containing the environment variables to pass to a container. This parameter maps to the `--env-file` option to `docker run`. Consists (value, type = \"s3\")"
  default     = []
}

variable "secrets" {
  type        = list(any)
  description = "An object representing the secret to expose to your container. For more information, see [Passing sensitive data to a container](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/specifying-sensitive-data.html). Consists (name, valueFrom)"
  default     = []
}

variable "region" {
  type        = string
  description = "Aws region for cloud watch logs to exist in."
  default     = "us-east-1"
}

variable "network_mode" {
  type        = string # "none" | "bridge" | "awsvpc" | "host"
  description = "Docker networking mode to use for the containers in the task. Valid values are `none`, `bridge`, `awsvpc`, and `host`."
  default     = "bridge"
}

variable "requires_compatibilities" {
  type        = list(string)
  description = "Set of launch types required by the task. The valid values are `EC2` and `FARGATE`."
  default     = ["EC2"]
}

variable "operating_system_family" {
  type        = string
  description = "If the requires_compatibilities is `FARGATE` this field is required; must be set to a valid option from the operating system family in the runtime platform setting."
  default     = null
}

variable "cpu_architecture" {
  type        = string # "X86_64" | "ARM64"
  description = "Must be set to either `X86_64` or `ARM64`; see cpu architecture."
  default     = null
}

variable "task_cpu" {
  type        = string # can be expressed as integer ('1024' for 1024 units) or a string for vCPUs ('1 vcpu' for 1 vcpu)
  description = "Number of cpu units used by the task. If the `requires_compatibilities` is `FARGATE` this field is required."
  default     = null
}

variable "ephemeral_storage" {
  type        = map(any) # 21 <= value <= 200
  description = "Ephemeral storage block, consists (size_in_gib): The minimum supported value is `21` GiB and the maximum supported value is `200` GiB. This parameter is used to expand the total amount of ephemeral storage available, beyond the default amount, for tasks hosted on AWS Fargate. See main.tf"
  default     = {}
}

variable "task_memory" {
  type        = string # can be expressed as integer ('1024' for 1024 MiBs) or a string using GB ('1GB' for 1 GB of memory)
  description = "Amount (in MiB) of memory used for the task. Killed if exceeded. Required if requires_compatibilities is FARGATE"
  default     = null
}

variable "task_role_arn" {
  type        = string
  description = "ARN of IAM role that allows containers to make calls to other AWS sevices"
  default     = null
}

variable "execution_role_arn" {
  type        = string
  description = "ARN of task execution role that container or daemon can assume"
  default     = null
}

# ----------------------------------------------------
# ecs service parameters
# ----------------------------------------------------
variable "launch_type" {
  type        = string # "EC2" | "FARGATE" | "EXTERNAL"
  description = "Launch type on which to run your service. The valid values are `EC2`, `FARGATE`, and `EXTERNAL`. Defaults to `EC2`."
  default     = "EC2"
}

variable "health_check_grace_period_seconds" {
  type        = number
  description = "Seconds to ignore failing load balancer health checks on newly instantiated tasks to prevent premature shutdown, up to 2147483647. Only valid for services configured to use load balancers."
  default     = 0
}

variable "service_registries" {
  type        = map(any)
  description = "Service discovery registries for the service. The maximum number of `service_registries` blocks is `1`. Consists (port, container_name, container_port). See main.tf"
  default     = {}
}

variable "load_balancer" {
  type        = map(any)
  description = "Configuration block for load balancers. Consists (target_group_arn, container_name, container_port). See main.tf"
  default     = {}
}

variable "network_configuration" {
  type        = map(any)
  description = "Network configuration for the service. This parameter is required for task definitions that use the `awsvpc` network mode to receive their own Elastic Network Interface, and it is not supported for other network modes. Consists (subnets, security_groups, assign_public_ip) see main.tf."
  default     = {}
}
