include {
  path = "${find_in_parent_folders()}"
}

terraform {
  source = "../../../../../modules/example1"
}

inputs = {
  input1 = "something"
}
