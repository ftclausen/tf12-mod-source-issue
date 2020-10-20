module "sibling1_mod" {
  source = "../sibling1"
}

module "sibling2_mod" {
  source = "../sibling2"
}

variable "input1" {
}

variable "collection" {
  description = "A collection"
  default = ["something", "else"]
  type = list
}
