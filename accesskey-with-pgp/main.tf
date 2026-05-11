# Copyright IBM Corp. 2022, 2026

resource "aws_iam_access_key" "roger" {
  user    = "roger"
  pgp_key = "keybase:roger"
}
