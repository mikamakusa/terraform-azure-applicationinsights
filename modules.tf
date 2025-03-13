module "storage" {
  source = "./modules/terraform-azure-storage"
  account = var.storage_account
  container = var.storage_container
}