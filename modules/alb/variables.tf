# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "external_instance_sg_id" {
  description = "The security group id of the external target instance"
  type        = string
  default     = null
}

variable "internal_instance_sg_id" {
  description = "The security group id of the internal target instance"
  type        = string
  default     = null
}

variable "vpc_cidr" {
  description = "The VPC CIDR block of variable.vpc_id"
  type        = string
  default     = null
}

# ----------------------------------------------------
# external security group parameters
# ----------------------------------------------------

variable "external_sg_description" {
  type    = string
  default = "Security group attached to external alb managed by terraform"
}

# ingress rules
variable "external_sg_ingress_with_cidr_blocks" {
  description = "List of ingress rules to create where 'cidr_blocks' is used"
  type = list(object({
    cidr_blocks = string
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
  }))
  default = [
    {
      cidr_blocks = "0.0.0.0/0"
      description = "Allow all HTTP inbound traffic on the load balancer listener port"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
    },
    {
      cidr_blocks = "0.0.0.0/0"
      description = "Allow all HTTPS inbound traffic on the load balancer listener port"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
    }
  ]
}

variable "external_sg_ingress_with_source_security_group_id" {
  description = "List of ingress rules to create where 'source_security_group_id' is used"
  type = list(object({
    source_security_group_id = string
    description              = string
    from_port                = number
    to_port                  = number
    protocol                 = string
  }))
  default = []
}

# egress rules
variable "external_sg_egress_with_cidr_blocks" {
  description = "List of egress rules to create where 'cidr_blocks' is used (set to [] if using external_sg_egress_with_source_security_group_id, see main.tf locals)"
  type = list(object({
    cidr_blocks = string
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
  }))
  default = [
    {
      cidr_blocks = "0.0.0.0/0"
      description = "Allow all HTTP outbound traffic to instances on the instance listener and healthcheck port"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
    },
    {
      cidr_blocks = "0.0.0.0/0"
      description = "Allow all HTTPS outbound traffic to instances on the instance listener and healthcheck port"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
    }
  ]
}

variable "external_sg_egress_with_source_security_group_id" {
  description = "List of egress rules to create where 'source_security_group_id' is used (external_sg_egress_with_cidr_blocks set to [] if using this variable, see main.tf locals)"
  type = list(object({
    source_security_group_id = string
    description              = string
    from_port                = number
    to_port                  = number
    protocol                 = string
  }))
  default = []
}

# ----------------------------------------------------
# internal security group parameters
# ----------------------------------------------------

variable "internal_sg_description" {
  type    = string
  default = "Security group attached to internal alb managed by terraform"
}

# ingress rules
variable "internal_sg_ingress_with_cidr_blocks" {
  description = "List of ingress rules to create where 'cidr_blocks' is used (if vpc_cidr is set, default rules set with cidr_blocks, see main.tf locals)"
  type = list(object({
    cidr_blocks = string
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
  }))
  default = [
    {
      cidr_blocks = "0.0.0.0/0"
      description = "Allow all HTTP inbound traffic on the load balancer listener port"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
    }
  ]
}

variable "internal_sg_ingress_with_source_security_group_id" {
  description = "List of ingress rules to create where 'source_security_group_id' is used"
  type = list(object({
    source_security_group_id = string
    description              = string
    from_port                = number
    to_port                  = number
    protocol                 = string
  }))
  default = []
}

# egress rules
variable "internal_sg_egress_with_cidr_blocks" {
  description = "List of egress rules to create where 'cidr_blocks' is used (set to [] if using internal_sg_egress_with_source_security_group_id, see main.tf locals)"
  type = list(object({
    cidr_blocks = string
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
  }))
  default = [
    {
      cidr_blocks = "0.0.0.0/0"
      description = "Allow all HTTP outbound traffic to instances on the instance listener and healthcheck port"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
    }
  ]
}

variable "internal_sg_egress_with_source_security_group_id" {
  description = "List of egress rules to create where 'source_security_group_id' is used (internal_sg_egress_with_cidr_blocks set to [] if using this variable, see main.tf locals)"
  type = list(object({
    source_security_group_id = string
    description              = string
    from_port                = number
    to_port                  = number
    protocol                 = string
  }))
  default = []
}

# ----------------------------------------------------
# external application load balancer parameters
# ----------------------------------------------------

variable "create_external_alb" {
  type    = bool
  default = true
}

# ----------------------------------------------------
# internal application load balancer parameters
# ----------------------------------------------------

variable "create_internal_alb" {
  type    = bool
  default = true
}