# Copyright IBM Corp. 2022, 2026

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
