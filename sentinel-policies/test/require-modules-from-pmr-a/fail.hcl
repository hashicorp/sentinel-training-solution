# Copyright IBM Corp. 2022, 2026

param "organization" {
  value = "Cloud-Operations"
}

mock "tfconfig/v2" {
  module {
    source = "mock-tfconfig-fail.sentinel"
  }
}

test {
  rules = {
    main = false
  }
}
