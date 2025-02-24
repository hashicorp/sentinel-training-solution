# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

param "the_number" {
     value = 8
}

test {
  rules = {
    main = true
  }
}
