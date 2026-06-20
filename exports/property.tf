terraform {
  required_providers {
    akamai = {
      source  = "akamai/akamai"
      version = ">= 10.1.0"
    }
  }
  required_version = ">= 1.0"
}

provider "akamai" {
  edgerc         = var.edgerc_path
  config_section = var.config_section
}

data "akamai_property_rules_template" "rules" {
  template_file = abspath("${path.module}/property-snippets/main.json")
}

resource "akamai_edge_hostname" "waap-akamaiuwebfraud-com-edgekey-net" {
  contract_id   = var.contract_id
  group_id      = var.group_id
  ip_behavior   = "IPV6_COMPLIANCE"
  product_id    = "prd_SPM"
  edge_hostname = "waap.akamaiuwebfraud.com.edgekey.net"
  certificate   = 204115
}

resource "akamai_property" "_2302-ds0a" {
  name        = "2302-ds0a"
  contract_id = var.contract_id
  group_id    = var.group_id
  product_id  = "prd_SPM"
  hostnames {
    cname_from             = "2302-ds0a.akamaiuwebfraud.com"
    cname_to               = akamai_edge_hostname.waap-akamaiuwebfraud-com-edgekey-net.edge_hostname
    cert_provisioning_type = "CPS_MANAGED"
  }
  rule_format = "v2022-10-18"
  rules       = data.akamai_property_rules_template.rules.json
}

# NOTE: Be careful when removing this resource as you can disable traffic
resource "akamai_property_activation" "_2302-ds0a-staging" {
  property_id                    = akamai_property._2302-ds0a.id
  contact                        = ["noreply@akamai.com", "student7265@akamaiu.com", "studentda3b@akamaiu.com"]
  version                        = var.activate_latest_on_staging ? akamai_property._2302-ds0a.latest_version : akamai_property._2302-ds0a.staging_version
  network                        = "STAGING"
  auto_acknowledge_rule_warnings = false
}

# NOTE: Be careful when removing this resource as you can disable traffic
resource "akamai_property_activation" "_2302-ds0a-production" {
  property_id                    = akamai_property._2302-ds0a.id
  contact                        = ["noreply@akamai.com", "student7265@akamaiu.com"]
  version                        = var.activate_latest_on_production ? akamai_property._2302-ds0a.latest_version : akamai_property._2302-ds0a.production_version
  network                        = "PRODUCTION"
  auto_acknowledge_rule_warnings = false
}
