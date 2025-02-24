# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

mock "tfrun" {
  module {
    source = "mock-tfrun-fail-prefix.sentinel"
  }
}

test {
  rules = {
    main = false
  }
}
