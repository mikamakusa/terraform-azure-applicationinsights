output "webtest_id" {
  value = azurerm_application_insights_web_test.this.*.id
}

output "webtests_synthetic_id" {
  value = azurerm_application_insights_web_test.this.*.synthetic_monitor_id
}

output "read_telemetry_api_key" {
  value = azurerm_application_insights_api_key.this.*.api_key
}

output "write_annotations_api_key" {
  value = azurerm_application_insights_api_key.this.*.api_key
}

output "authenticate_sdk_control_channel" {
  value = azurerm_application_insights_api_key.this.*.api_key
}

output "full_permissions_api_key" {
  value = azurerm_application_insights_api_key.this.*.api_key
}

output "instrumentation_key" {
  value = azurerm_application_insights.this.*.instrumentation_key
}

output "app_id" {
  value = azurerm_application_insights.this.*.app_id
}