resource "azurerm_application_insights" "this" {
  count            = (length(var.resource_group) || var.resource_group_name != null) == 0 ? 0 : length(var.application_insights)
  application_type = lookup(var.application_insights[count.index], "application_type")
  location = var.resource_group_name == null ? try(
  element(azurerm_resource_group.this.*.location, lookup(var.application_insights[count.index], "resource_group_id"))) : data.azurerm_resource_group.this.location
  name = lookup(var.application_insights[count.index], "name")
  resource_group_name = var.resource_group_name == null ? try(
  element(azurerm_resource_group.this.*.name, lookup(var.application_insights[count.index], "resource_group_id"))) : data.azurerm_resource_group.this.name
  daily_data_cap_in_gb                  = lookup(var.application_insights[count.index], "daily_data_cap_in_gb")
  daily_data_cap_notifications_disabled = lookup(var.application_insights[count.index], "daily_data_cap_notifications_disabled")
  disable_ip_masking                    = lookup(var.application_insights[count.index], "disable_ip_masking")
  force_customer_storage_for_profiler   = lookup(var.application_insights[count.index], "force_customer_storage_for_profiler")
  internet_ingestion_enabled            = lookup(var.application_insights[count.index], "internet_ingestion_enabled")
  internet_query_enabled                = lookup(var.application_insights[count.index], "internet_query_enabled")
  local_authentication_disabled         = lookup(var.application_insights[count.index], "local_authentication_disabled")
  retention_in_days                     = lookup(var.application_insights[count.index], "retention_in_days")
  sampling_percentage                   = lookup(var.application_insights[count.index], "sampling_percentage")
  tags                                  = merge(var.tags, lookup(var.application_insights[count.index], "tags"))
  workspace_id                          = lookup(var.application_insights[count.index], "workspace_id")
}

resource "azurerm_application_insights_analytics_item" "this" {
  count = length(var.application_insights) == 0 ? 0 : length(var.analytics_item)
  application_insights_id = try(
  element(azurerm_application_insights.this.*.id, lookup(var.analytics_item[count.index], "application_insights_id")))
  content        = lookup(var.analytics_item[count.index], "type") == "query" ? lookup(var.analytics_item[count.index], "content") : null
  name           = lookup(var.analytics_item[count.index], "name")
  scope          = lookup(var.analytics_item[count.index], "scope")
  type           = lookup(var.analytics_item[count.index], "type")
  function_alias = lookup(var.analytics_item[count.index], "type") == "function" ? lookup(var.analytics_item[count.index], "function_alias") : null
}

resource "azurerm_application_insights_api_key" "this" {
  count                   = length(var.application_insights) == 0 ? 0 : length(var.api_key)
  application_insights_id = try(element(azurerm_application_insights.this.*.id, lookup(var.api_key[count.index], "application_insights_id")))
  name                    = lookup(var.api_key[count.index], "name")
  read_permissions        = lookup(var.api_key[count.index], "read_permissions")
  write_permissions       = lookup(var.api_key[count.index], "write_permissions")
}

resource "azurerm_application_insights_smart_detection_rule" "this" {
  count                              = length(var.application_insights) == 0 ? 0 : length(var.smart_detection_rule)
  application_insights_id            = try(element(azurerm_application_insights.this.*.id, lookup(var.smart_detection_rule[count.index], "application_insights_id")))
  name                               = lookup(var.smart_detection_rule[count.index], "name")
  additional_email_recipients        = lookup(var.smart_detection_rule[count.index], "additional_email_recipients")
  enabled                            = lookup(var.smart_detection_rule[count.index], "enabled")
  send_emails_to_subscription_owners = lookup(var.smart_detection_rule[count.index], "send_emails_to_subscription_owners")
}

resource "azurerm_application_insights_standard_web_test" "this" {
  count = (length(var.application_insights) && (length(var.resource_group) || var.resource_group_name != null)) == 0 ? 0 : length(var.standard_web_test)
  application_insights_id = try(
    element(azurerm_application_insights.this.*.id, lookup(var.standard_web_test[count.index], "application_insights_id"))
  )
  geo_locations = lookup(var.standard_web_test[count.index], "geo_locations")
  location = var.resource_group_name != null ? data.azurerm_resource_group.this.location : try(
    element(azurerm_resource_group.this.*.location, lookup(var.standard_web_test[count.index], "resource_group_id"))
  )
  name = lookup(var.standard_web_test[count.index], "name")
  resource_group_name = var.resource_group_name != null ? data.azurerm_resource_group.this.name : try(
    element(azurerm_resource_group.this.*.name, lookup(var.standard_web_test[count.index], "resource_group_id"))
  )
  description   = lookup(var.standard_web_test[count.index], "description")
  enabled       = lookup(var.standard_web_test[count.index], "enabled")
  frequency     = lookup(var.standard_web_test[count.index], "frequency")
  retry_enabled = lookup(var.standard_web_test[count.index], "retry_enabled")
  tags          = merge(var.tags, lookup(var.standard_web_test[count.index], "tags"))
  timeout       = lookup(var.standard_web_test[count.index], "timeout")

  dynamic "request" {
    for_each = lookup(var.standard_web_test[count.index], "request")
    content {
      url                              = lookup(request.value, "url")
      body                             = lookup(request.value, "body")
      follow_redirects_enabled         = lookup(request.value, "follow_redirects_enabled")
      http_verb                        = lookup(request.value, "http_verb")
      parse_dependent_requests_enabled = lookup(request.value, "parse_dependent_requests_enabled")

      dynamic "header" {
        for_each = lookup(request.value, "header") == null ? [] : ["header"]
        content {
          value = lookup(header.value, "value")
          name  = lookup(header.value, "name")
        }
      }
    }
  }

  dynamic "validation_rules" {
    for_each = lookup(var.standard_web_test[count.index], "validation_rules") == null ? [] : ["validation_rules"]
    content {
      expected_status_code        = lookup(validation_rules.value, "expected_status_code")
      ssl_cert_remaining_lifetime = lookup(validation_rules.value, "ssl_cert_remaining_lifetime")
      ssl_check_enabled           = lookup(validation_rules.value, "ssl_check_enabled")

      dynamic "content" {
        for_each = lookup(validation_rules.value, "content") == null ? [] : ["content"]
        content {
          content_match      = lookup(content.value, "content_match")
          ignore_case        = lookup(content.value, "ignore_case")
          pass_if_text_found = lookup(content.value, "pass_if_text_found")
        }
      }
    }
  }
}

resource "azurerm_application_insights_web_test" "this" {
  count = ((length(var.resource_group) || var.resource_group_name != null) && length(var.application_insights)) == 0 ? 0 : length(var.web_test)
  application_insights_id = try(
    element(azurerm_application_insights.this.*.id, lookup(var.web_test[count.index], "application_insights_id"))
  )
  configuration = lookup(var.web_test[count.index], "configuration")
  geo_locations = lookup(var.web_test[count.index], "geo_locations")
  kind          = lookup(var.web_test[count.index], "kind")
  location = var.resource_group_name != null ? data.azurerm_resource_group.this.location : try(
    element(azurerm_resource_group.this.*.name, lookup(var.web_test[count.index], "resource_group_id"))
  )
  name = lookup(var.web_test[count.index], "name")
  resource_group_name = var.resource_group_name != null ? data.azurerm_resource_group.this.name : try(
    element(azurerm_resource_group.this.*.name, lookup(var.web_test[count.index], "resource_group_id"))
  )
  frequency     = lookup(var.web_test[count.index], "frequency")
  timeout       = lookup(var.web_test[count.index], "timeout")
  enabled       = lookup(var.web_test[count.index], "enabled")
  retry_enabled = lookup(var.web_test[count.index], "retry_enabled")
  description   = lookup(var.web_test[count.index], "description")
  tags = merge(
    var.tags,
    lookup(var.web_test[count.index], "tags")
  )
}

resource "azurerm_application_insights_workbook" "this" {
  count        = (length(var.resource_group) || var.resource_group_name != null) == 0 ? 0 : length(var.workbook)
  data_json    = jsonencode(lookup(var.workbook[count.index], "data_json"))
  display_name = lookup(var.workbook[count.index], "display_name")
  location = var.resource_group_name != null ? data.azurerm_resource_group.this.location : try(
    element(azurerm_resource_group.this.*.name, lookup(var.workbook[count.index], "resource_group_id"))
  )
  name = lookup(var.workbook[count.index], "name")
  resource_group_name = var.resource_group_name != null ? data.azurerm_resource_group.this.name : try(
    element(azurerm_resource_group.this.*.name, lookup(var.workbook[count.index], "resource_group_id"))
  )
  source_id   = ""
  category    = lookup(var.workbook[count.index], "category")
  description = lookup(var.workbook[count.index], "description")
  storage_container_id = var.storage_container_name == null ? try(
    element(module.storage.*.container_id, lookup(var.workbook[count.index], "sotrage_container_id"))
  ) : data.azurerm_storage_container.this.id
  tags = merge(var.tags, lookup(var.workbook[count.index], "tags"))

  dynamic "identity" {
    for_each = lookup(var.workbook[count.index], "identity") == null ? [] : ["identity"]
    content {
      type         = lookup(identity.value, "type")
      identity_ids = lookup(identity.value, "identity_ids")
    }
  }
}

resource "azurerm_application_insights_workbook_template" "this" {
  count = (length(var.resource_group) || var.resource_group_name != null) == 0 ? 0 : length(var.workbook_template)
  location = var.resource_group_name != null ? data.azurerm_resource_group.this.location : try(
    element(azurerm_resource_group.this.*.name, lookup(var.workbook_template[count.index], "resource_group_id"))
  )
  name = lookup(var.workbook_template[count.index], "name")
  resource_group_name = var.resource_group_name != null ? data.azurerm_resource_group.this.name : try(
    element(azurerm_resource_group.this.*.name, lookup(var.workbook_template[count.index], "resource_group_id"))
  )
  template_data = jsonencode(lookup(var.workbook_template[count.index], "template_data"))
  author        = lookup(var.workbook_template[count.index], "author")
  localized     = lookup(var.workbook_template[count.index], "localized")
  priority      = lookup(var.workbook_template[count.index], "priority")
  tags = merge(
    var.tags,
    lookup(var.workbook_template[count.index], "tags")
  )

  dynamic "galleries" {
    for_each = lookup(var.workbook_template[count.index], "galleries")
    content {
      category = lookup(galleries.value, "category")
      name     = lookup(galleries.value, "name")
    }
  }
}