terraform {
  required_providers {
    akamai = {
      source  = "akamai/akamai"
      version = "10.2.0"
    }
  }

  required_version = ">= 1.0"
}

provider "akamai" {
  edgerc         = "~/.edgerc"
  config_section = "default"
}

data "akamai_property" "test_property" {
  name        = "2302-ds0a"
  
}

output "property_summary" {
  value = {
    property_id        = data.akamai_property.test_property.property_id
    latest_version     = data.akamai_property.test_property.latest_version
    production_version = data.akamai_property.test_property.production_version
    staging_version    = data.akamai_property.test_property.staging_version
    product_id         = data.akamai_property.test_property.product_id
    rule_format        = data.akamai_property.test_property.rule_format
  }
}