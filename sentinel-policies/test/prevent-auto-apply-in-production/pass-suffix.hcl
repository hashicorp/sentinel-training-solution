# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

mock "tfrun" {
  module {
    source = "mock-tfrun-pass-suffix.sentinel"
  }
}

test {
  rules = {
    main = true
  }
}
