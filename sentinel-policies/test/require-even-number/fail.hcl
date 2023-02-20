# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

param "the_number" {
     value = 5
}

test {
  rules = {
    main = false
  }
}
