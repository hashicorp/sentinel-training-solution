# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

param "organization" {
  value = "Cloud-Operations"
}

module "module-functions" {
  source = "../../common-functions/module-functions/module-functions.sentinel"
}

mock "tfconfig/v2" {
  module {
    source = "mock-tfconfig-pass.sentinel"
  }
}

test {
  rules = {
    main = true
  }
}
