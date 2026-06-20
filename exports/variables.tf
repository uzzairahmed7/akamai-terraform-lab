variable "edgerc_path" {
  type    = string
  default = "C:\Users\uzzai/.edgerc"
}

variable "config_section" {
  type    = string
  default = "default"
}

variable "contract_id" {
  type    = string
  default = "ctr_V-3YSNQK2"
}

variable "group_id" {
  type    = string
  default = "grp_211815"
}

variable "activate_latest_on_staging" {
  type    = bool
  default = true
}

variable "activate_latest_on_production" {
  type    = bool
  default = false
}
