## Requirements

| Name | Version     |
|------|-------------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | \>= 3.109.0 |

## Providers

| Name | Version     |
|------|-------------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | \>= 3.109.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_application_insights.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) | resource |
| [azurerm_application_insights_analytics_item.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights_analytics_item) | resource |
| [azurerm_application_insights_api_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights_api_key) | resource |
| [azurerm_application_insights_smart_detection_rule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights_smart_detection_rule) | resource |
| [azurerm_application_insights_standard_web_test.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights_standard_web_test) | resource |
| [azurerm_application_insights_web_test.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights_web_test) | resource |
| [azurerm_application_insights_workbook.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights_workbook) | resource |
| [azurerm_application_insights_workbook_template.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights_workbook_template) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_storage_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_storage_container.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_container) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_analytics_item"></a> [analytics\_item](#input\_analytics\_item) | n/a | <pre>list(object({<br>    id                      = number<br>    application_insights_id = number<br>    content                 = string<br>    name                    = string<br>    scope                   = string<br>    type                    = string<br>    function_alias          = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_api_key"></a> [api\_key](#input\_api\_key) | n/a | <pre>list(object({<br>    id                      = number<br>    application_insights_id = number<br>    name                    = string<br>    read_permissions        = optional(list(string))<br>    write_permissions       = optional(list(string))<br>  }))</pre> | `[]` | no |
| <a name="input_application_insights"></a> [application\_insights](#input\_application\_insights) | n/a | <pre>list(object({<br>    id                                    = number<br>    application_type                      = string<br>    name                                  = string<br>    resource_group_id                     = number<br>    daily_data_cap_in_gb                  = optional(number)<br>    daily_data_cap_notifications_disabled = optional(bool)<br>    disable_ip_masking                    = optional(bool)<br>    force_customer_storage_for_profiler   = optional(bool)<br>    internet_ingestion_enabled            = optional(bool)<br>    internet_query_enabled                = optional(bool)<br>    local_authentication_disabled         = optional(bool)<br>    retention_in_days                     = optional(number)<br>    sampling_percentage                   = optional(number)<br>    tags                                  = optional(map(string))<br>    workspace_id                          = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | n/a | <pre>list(object({<br>    id       = number<br>    location = string<br>    name     = string<br>  }))</pre> | `[]` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | `null` | no |
| <a name="input_smart_detection_rule"></a> [smart\_detection\_rule](#input\_smart\_detection\_rule) | n/a | <pre>list(object({<br>    id                                 = number<br>    application_insights_id            = number<br>    name                               = string<br>    additional_email_recipients        = optional(list(string))<br>    enabled                            = optional(bool)<br>    send_emails_to_subscription_owners = optional(bool)<br>  }))</pre> | `[]` | no |
| <a name="input_standard_web_test"></a> [standard\_web\_test](#input\_standard\_web\_test) | n/a | <pre>list(object({<br>    id                      = number<br>    application_insights_id = number<br>    geo_locations           = list(string)<br>    name                    = string<br>    resource_group_id       = number<br>    description             = optional(string)<br>    enabled                 = optional(bool)<br>    frequency               = optional(number)<br>    retry_enabled           = optional(bool)<br>    tags                    = optional(map(string))<br>    timeout                 = optional(number)<br>    request = list(object({<br>      url                              = string<br>      body                             = optional(string)<br>      follow_redirects_enabled         = optional(bool)<br>      http_verb                        = optional(string)<br>      parse_dependent_requests_enabled = optional(bool)<br>      header = optional(list(object({<br>        name  = string<br>        value = string<br>      })), [])<br>    }))<br>    validation_rules = optional(list(object({<br>      expected_status_code        = optional(number)<br>      ssl_cert_remaining_lifetime = optional(number)<br>      ssl_check_enabled           = optional(bool)<br>      content = optional(list(object({<br>        content_match      = optional(string)<br>        ignore_case        = optional(bool)<br>        pass_if_text_found = optional(bool)<br>      })), [])<br>    })), [])<br>  }))</pre> | `[]` | no |
| <a name="input_storage_account"></a> [storage\_account](#input\_storage\_account) | n/a | <pre>list(object({<br>    id                       = number<br>    account_replication_type = string<br>    account_tier             = string<br>    name                     = string<br>    resource_group_id        = number<br>  }))</pre> | `[]` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | n/a | `string` | `null` | no |
| <a name="input_storage_container"></a> [storage\_container](#input\_storage\_container) | n/a | <pre>list(object({<br>    id                 = number<br>    name               = string<br>    storage_account_id = number<br>  }))</pre> | `[]` | no |
| <a name="input_storage_container_name"></a> [storage\_container\_name](#input\_storage\_container\_name) | n/a | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_web_test"></a> [web\_test](#input\_web\_test) | n/a | <pre>list(object({<br>    id                      = number<br>    application_insights_id = number<br>    configuration           = string<br>    geo_locations           = list(string)<br>    kind                    = string<br>    name                    = string<br>    resource_group_id       = number<br>    frequency               = optional(number)<br>    timeout                 = optional(number)<br>    enabled                 = optional(bool)<br>    retry_enabled           = optional(number)<br>    description             = optional(string)<br>    tags                    = optional(map(string))<br>  }))</pre> | `[]` | no |
| <a name="input_workbook"></a> [workbook](#input\_workbook) | n/a | <pre>list(object({<br>    id                   = number<br>    data_json            = string<br>    display_name         = string<br>    location             = string<br>    name                 = string<br>    resource_group_id    = number<br>    source_id            = optional(string)<br>    category             = optional(string)<br>    description          = optional(string)<br>    storage_container_id = optional(string)<br>    tags                 = optional(map(string))<br>    identity = optional(list(object({<br>      type         = string<br>      identity_ids = optional(list(string))<br>    })), [])<br>  }))</pre> | `[]` | no |
| <a name="input_workbook_template"></a> [workbook\_template](#input\_workbook\_template) | n/a | <pre>list(object({<br>    id                = number<br>    name              = string<br>    resource_group_id = number<br>    template_data     = string<br>    author            = optional(string)<br>    localized         = optional(string)<br>    priority          = optional(number)<br>    tags              = optional(map(string))<br>    galleries = optional(list(object({<br>      category      = string<br>      name          = string<br>      order         = optional(number)<br>      resource_type = optional(string)<br>      type          = optional(string)<br>    })), [])<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_id"></a> [app\_id](#output\_app\_id) | n/a |
| <a name="output_authenticate_sdk_control_channel"></a> [authenticate\_sdk\_control\_channel](#output\_authenticate\_sdk\_control\_channel) | n/a |
| <a name="output_full_permissions_api_key"></a> [full\_permissions\_api\_key](#output\_full\_permissions\_api\_key) | n/a |
| <a name="output_instrumentation_key"></a> [instrumentation\_key](#output\_instrumentation\_key) | n/a |
| <a name="output_read_telemetry_api_key"></a> [read\_telemetry\_api\_key](#output\_read\_telemetry\_api\_key) | n/a |
| <a name="output_webtest_id"></a> [webtest\_id](#output\_webtest\_id) | n/a |
| <a name="output_webtests_synthetic_id"></a> [webtests\_synthetic\_id](#output\_webtests\_synthetic\_id) | n/a |
| <a name="output_write_annotations_api_key"></a> [write\_annotations\_api\_key](#output\_write\_annotations\_api\_key) | n/a |
