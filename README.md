# SOLVED

It turns out I need to specify a double slash, `//`, **from the calling code** not at the module level. So `service1`
needs a double slash after the base directory containing all modules

```
terraform {
  source = "../../../../..//modules/example1"
}
```

Here it being `//modules` the slash being at the repo base.

# Previous description

## What is this?

This is a contrived, minimal project to reproduce an issue with terragrunt not copying transitive modules present in the
same repo.

## Executive summary

Terragrunt copies the _calling_ code and first level dependencies to the `.terragrunt-cache` directory. However it does
not copy transitive dependencies meaning the `init` or `plan` runs will not work if the dependent module itself has
dependencies. In this repo `service1` uses `modules/example1` that in turn depends on `modules/sibling1` and `modules/sibling2`

## How to reproduce

1. Install Terraform (12.x series, we use v0.12.26) and Terragrunt (v0.25.4 - grabbed latest release as of this writing)
2. Clone this repo
3. `cd accounts/account1/earth/dev/service1`
4. `export ACCOUNT=account1 ; export REGION=earth ; export ENVIRONMENT=dev`
5. Run `terragrunt init`
6. Observe `Unable to evaluate directory symlink: lstat ../sibling1: no such file or directory`

## Layout

The layout roughly replicas our internal repo minus some convenience wrapper for terragrunt to run over the multiple
accounts and projects:

```
.
├── README.md
├── accounts
│   ├── account1
│   │   ├── common.hcl
│   │   └── earth
│   │       └── dev
│   │           ├── common.hcl
│   │           └── service1
│   │               └── terragrunt.hcl
│   └── terragrunt.hcl
├── common
│   └── account1-dev-earth.tfvars
├── modules
│   ├── example1
│   │   ├── main.tf
│   │   └── terragrunt.hcl
│   ├── sibling1
│   │   ├── main.tf
│   │   └── terragrunt.hcl
│   └── sibling2
│       ├── main.tf
│       └── terragrunt.hcl
└── terragrunt.py
```
