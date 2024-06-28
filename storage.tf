resource "azurerm_storage_account" "this" {
  count                    = length(var.storage_account)
  account_replication_type = lookup(var.storage_account[count.index], "account_replication_type")
  account_tier             = lookup(var.storage_account[count.index], "account_tier")
  location                 = lookup(var.storage_account[count.index], "location")
  name                     = lookup(var.storage_account[count.index], "name")
  resource_group_name      = var.resource_group_name == null ? try(
    element(azurerm_resource_group.this.*.name, lookup(var.storage_account[count.index], "resource_group_id"))
  ) : data.azurerm_resource_group.this.name
}

resource "azurerm_storage_container" "this" {
  count                = length(var.storage_account) == 0 ? 0 : length(var.storage_container)
  name                 = lookup(var.storage_container[count.index], "name")
  storage_account_name = var.storage_account_name == null ? try(
    element(azurerm_storage_account.this.*.name, lookup(var.storage_container[count.index], "storage_account_id"))
  ) : data.azurerm_storage_account.this.name
}