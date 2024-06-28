resource "azurerm_resource_group" "this" {
  count    = var.resource_group_name == null ? length(var.resource_group) : []
  location = lookup(var.resource_group[count.index], "location")
  name     = lookup(var.resource_group[count.index], "name")
}