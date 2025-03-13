variable "resource_group_name" {
  type    = string
  default = null
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "resource_group" {
  type = list(object({
    id       = number
    location = string
    name     = string
  }))
  default = []
}

variable "application_insights" {
  type = list(object({
    id                                    = number
    application_type                      = string
    name                                  = string
    resource_group_id                     = number
    daily_data_cap_in_gb                  = optional(number)
    daily_data_cap_notifications_disabled = optional(bool)
    disable_ip_masking                    = optional(bool)
    force_customer_storage_for_profiler   = optional(bool)
    internet_ingestion_enabled            = optional(bool)
    internet_query_enabled                = optional(bool)
    local_authentication_disabled         = optional(bool)
    retention_in_days                     = optional(number)
    sampling_percentage                   = optional(number)
    tags                                  = optional(map(string))
    workspace_id                          = optional(string)
  }))
  default = []

  validation {
    condition = alltrue(
      [
        for i in var.application_insights : contains(["ios","java","MobileCenter","Node.JS","other","phone","store","web"], i.application_type)
      ]
    )
    error_message = "Valid values are ios for iOS, java for Java web, MobileCenter for App Center, Node.JS for Node.js, other for General, phone for Windows Phone, store for Windows Store and web for ASP.NET."
  }
}

variable "analytics_item" {
  type = list(object({
    id                      = number
    application_insights_id = number
    content                 = string
    name                    = string
    scope                   = string
    type                    = string
    function_alias          = optional(string)
  }))
  default = []

  validation {
    condition = alltrue(
      [
        for i in var.analytics_item : contains(["query", "function", "folder", "recent"], i.type)
      ]
    )
    error_message = "Valid values are query, function, folder, recent."
  }

  validation {
    condition = alltrue(
      [
        for i in var.analytics_item : contains(["shared", "user"], i.scope)
      ]
    )
    error_message = "Valid values are shared, user."
  }
}

variable "api_key" {
  type = list(object({
    id                      = number
    application_insights_id = number
    name                    = string
    read_permissions        = optional(list(string))
    write_permissions       = optional(list(string))
  }))
  default = []

  validation {
    condition = alltrue(
      [
        for i in var.api_key : contains(["agentconfig", "aggregate", "api", "draft", "extendqueries", "search"], i.read_permissions)
      ]
    )
    error_message = "Valid values are agentconfig, aggregate, api, draft, extendqueries, search."
  }
}

variable "smart_detection_rule" {
  type = list(object({
    id                                 = number
    application_insights_id            = number
    name                               = string
    additional_email_recipients        = optional(list(string))
    enabled                            = optional(bool)
    send_emails_to_subscription_owners = optional(bool)
  }))
  default = []

  validation {
    condition = alltrue(
      [
        for i in var.smart_detection_rule : contains(["Slow page load time",
        "Slow server response time", "Potential memory leak detected",
        "Potential security issue detected", "Long dependency duration",
        "Degradation in server response time", "Degradation in dependency duration"
      , "Degradation in trace severity ratio", "Abnormal rise in exception volume"
      , "Abnormal rise in daily data volume"], i.name)
      ]
    )
    error_message = "Valid values are Slow page load time, Slow server response time, Potential memory leak detected, Potential security issue detected, Long dependency duration, Degradation in server response time, Degradation in dependency duration, Degradation in trace severity ratio, Abnormal rise in exception volume, Abnormal rise in daily data volume."
  }
}

variable "standard_web_test" {
  type = list(object({
    id                      = number
    application_insights_id = number
    geo_locations           = list(string)
    name                    = string
    resource_group_id       = number
    description             = optional(string)
    enabled                 = optional(bool)
    frequency               = optional(number)
    retry_enabled           = optional(bool)
    tags                    = optional(map(string))
    timeout                 = optional(number)
    request = list(object({
      url                              = string
      body                             = optional(string)
      follow_redirects_enabled         = optional(bool)
      http_verb                        = optional(string)
      parse_dependent_requests_enabled = optional(bool)
      header = optional(list(object({
        name  = string
        value = string
      })), [])
    }))
    validation_rules = optional(list(object({
      expected_status_code        = optional(number)
      ssl_cert_remaining_lifetime = optional(number)
      ssl_check_enabled           = optional(bool)
      content = optional(list(object({
        content_match      = optional(string)
        ignore_case        = optional(bool)
        pass_if_text_found = optional(bool)
      })), [])
    })), [])
  }))
  default = []
}

variable "web_test" {
  type = list(object({
    id                      = number
    application_insights_id = number
    configuration           = string
    geo_locations           = list(string)
    kind                    = string
    name                    = string
    resource_group_id       = number
    frequency               = optional(number)
    timeout                 = optional(number)
    enabled                 = optional(bool)
    retry_enabled           = optional(number)
    description             = optional(string)
    tags                    = optional(map(string))
  }))
  default = []
}

variable "workbook" {
  type = list(object({
    id                   = number
    data_json            = string
    display_name         = string
    location             = string
    name                 = string
    resource_group_id    = number
    source_id            = optional(string)
    category             = optional(string)
    description          = optional(string)
    storage_container_id = optional(string)
    tags                 = optional(map(string))
    identity = optional(list(object({
      type         = string
      identity_ids = optional(list(string))
    })), [])
  }))
  default = []
}

variable "workbook_template" {
  type = list(object({
    id                = number
    name              = string
    resource_group_id = number
    template_data     = string
    author            = optional(string)
    localized         = optional(string)
    priority          = optional(number)
    tags              = optional(map(string))
    galleries = optional(list(object({
      category      = string
      name          = string
      order         = optional(number)
      resource_type = optional(string)
      type          = optional(string)
    })), [])
  }))
  default = []
}

variable "storage_account" {
  type = any
  default = []
}

variable "storage_account_name" {
  type    = string
  default = null
}

variable "storage_container_name" {
  type    = string
  default = null
}

variable "storage_container" {
  type = any
  default = []
}