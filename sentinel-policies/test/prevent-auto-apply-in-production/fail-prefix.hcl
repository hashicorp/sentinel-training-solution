mock "tfrun" {
  module {
    source = "mock-tfrun-fail-prefix.sentinel"
  }
}

test {
  rules = {
    main = false
  }
}
