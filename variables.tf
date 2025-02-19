variable "cluster" {
  description = "EKS cluster configuration"
  type = object({
    version                = string
    name                   = string
    endpoint_public_access = bool
  })
}

variable "network" {
  description = "Network configuration"
  type = object({
    azs             = list(string)
    cidr            = string
    private_subnets = list(string)
    public_subnets  = list(string)
  })
}
