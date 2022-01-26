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
