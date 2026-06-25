terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100"
    }
  }

  # Remote backend – same storage account you created for Project 2
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstateyourname"   # ← same one from project 2
    container_name       = "tfstate"
    key                  = "final-project.terraform.tfstate"   # different key so it doesn't clash
  }
}

provider "azurerm" {
  features {}
}
