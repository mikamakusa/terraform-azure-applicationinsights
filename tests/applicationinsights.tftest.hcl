run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "application_insights" {
  command = [init,plan,apply]

  variables {
    resource_group = [
      {
        id        = 0
        name      = "tf-test"
        location  = "West Europe"
      }
    ]
    application_insights = [
      {
        id                  = 0
        name                = "tf-test-appinsights"
        resource_group_id   = 0
        application_type    = "web"
      }
    ]
    analytics_item = [
      {
        id = 0
        name                    = "testquery"
        application_insights_id = 0
        content                 = "requests //simple example query"
        scope                   = "shared"
        type                    = "query"
      }
    ]
    api_key = [
      {
        id                      = 0
        name                    = "read-telemetry-api-key"
        application_insights_id = 0
        read_permissions        = ["aggregate", "api", "draft", "extendqueries", "search"]
      },
      {
        id                      = 1
        name                    = "write-annotations-api-key"
        application_insights_id = 0
        write_permissions       = ["annotations"]
      },
      {
        id                      = 2
        name                    = "authenticate-sdk-control-channel-api-key"
        application_insights_id = 0
        read_permissions        = ["agentconfig"]
      }
    ]
    smart_detection_rule = [
      {
        id                      = 0
        name                    = "Slow server response time"
        application_insights_id = 0
        enabled                 = true
      }
    ]
    standard_web_test = [
      {
        id                      = 0
        name                    = "example-test"
        resource_group_id       = 0
        application_insights_id = 0
        geo_locations           = ["example"]

        request = [
          {
            url = "http://www.example.com"
          }
        ]
      }
    ]
  }
}