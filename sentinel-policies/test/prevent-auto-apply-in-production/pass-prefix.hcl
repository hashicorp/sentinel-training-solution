# Copyright IBM Corp. 2022, 2026

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
