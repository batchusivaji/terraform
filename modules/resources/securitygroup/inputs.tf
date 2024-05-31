variable "security_group_info" {
  type = object({
    name = string
    vpc_id = string
    description = string
    inbound_rules = list(object({
        cidr = string
        type = string
        port = number
        protocol = string
    }))
    outbound_rules = list(object({
        cidr = string
        type = string
        from_port = number
        to_port = number
        protocol = string
  }))
 })
}
