# Copyright IBM Corp. 2022, 2026

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
