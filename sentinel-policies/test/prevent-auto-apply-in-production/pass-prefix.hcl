# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

mock "tfrun" {
  module {
    source = "mock-tfrun-pass-prefix.sentinel"
  }
}

test {
  rules = {
    main = true
  }
}
