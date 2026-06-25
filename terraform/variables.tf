variable "student_name" {
  description = "Your name – used in resource names and tags (lowercase, no spaces)"
  type        = string
  default     = "ayoub"   
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "spaincentral"
}

variable "acr_sku" {
  description = "Azure Container Registry SKU"
  type        = string
  default     = "Basic"
}

variable "aks_node_count" {
  description = "Number of AKS nodes"
  type        = number
  default     = 2
}

variable "aks_node_size" {
  description = "VM size for AKS nodes"
  type        = string
  default     = "Standard_B2s_v2"
}
