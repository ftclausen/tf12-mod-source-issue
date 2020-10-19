locals {
  default_widgets = {
    Name = "something"
    Product = "something else"
  }
}

provider "consul" {
  address = "localhost:8300"
  datacenter = "CA"
}
