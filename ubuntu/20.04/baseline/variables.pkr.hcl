# Provided by a Pipeline Secret 'ARM_SUBSCRIPTION_ID'
variable subscription_id {
  type        = string
  description = "Azure Subscription ID"
}
# Provided by a Pipeline Secret 'ARM_TENANT_ID'
variable tenant_id {
  type        = string
  description = "Azure Tenant ID"
}
# Provided by a Pipeline Secret 'ARM_CLIENT_ID'
variable client_id {
  type = string
}
# Provided by a Pipeline Secret 'ARM_CLIENT_SECRET'
variable "client_secret" {
  sensitive = true
  type      = string
}
# Provided by the PKRVAR file
variable location {
  type = string
}
# Provided by the PKRVAR file, MUST match an Image Definition in the Shared Compute Gallery
variable image_name {
  type = string
}
# Dynamically generated by the Pipeline
variable image_version {
  type = string
}
# Provided by the PKRVAR file
variable gallery_resource_group {
  type = string
}
# Provided by the PKRVAR file
variable gallery_name {
  type = string
}
# Dynamically obtained by the Pipeline
variable agent_ipaddress {
  type = string
}
# Provided by the PKRVAR file
variable vm_size {
  type = string
}
# Provided by the PKRVAR file
variable replication_regions {
  type = list(string)
}