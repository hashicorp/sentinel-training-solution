# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

mock "tfrun" {
  module {
    source = "mock-tfrun-fail-suffix.sentinel"
  }
}

test {
  rules = {
    main = false
  }
}
