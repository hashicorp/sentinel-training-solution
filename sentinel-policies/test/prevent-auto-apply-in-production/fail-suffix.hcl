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
