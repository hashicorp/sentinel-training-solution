# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

resource "aws_iam_access_key" "roger" {
  user    = "roger"
  pgp_key = "keybase:roger"
}
