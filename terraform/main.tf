locals {
  common_tags = {
    Project     = "Final"
    StudentName = var.student_name
  }
  # ACR name must be globally unique, alphanumeric only, 5-50 chars
  acr_name = "${replace(var.student_name, "-", "")}finalacr"
}

# ── Resource Group ─────────────────────────────────────────────────────────────
resource "azurerm_resource_group" "main" {
  name     = "${var.student_name}-final-rg"
  location = var.location
  tags     = local.common_tags
}

# ── Azure Container Registry (ACR) ────────────────────────────────────────────
resource "azurerm_container_registry" "acr" {
  name                = local.acr_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = var.acr_sku
  admin_enabled       = false   # AKS pulls via managed identity, no admin needed
  tags                = local.common_tags
}

# ── Azure Kubernetes Service (AKS) ────────────────────────────────────────────
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.student_name}-final-aks"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  dns_prefix          = "${var.student_name}-aks"
  tags                = local.common_tags

  # Fixes the 400 Bad Request error by explicitly keeping OIDC enabled
  oidc_issuer_enabled = true

  default_node_pool {
    name       = "default"
    node_count = var.aks_node_count
    vm_size    = var.aks_node_size
  }

  # System-assigned managed identity so AKS can pull from ACR without secrets
  identity {
    type = "SystemAssigned"
  }
}

# ── Grant AKS permission to pull images from ACR ──────────────────────────────
resource "azurerm_role_assignment" "aks_acr_pull" {
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}

# Triggering PR for project screenshot verification