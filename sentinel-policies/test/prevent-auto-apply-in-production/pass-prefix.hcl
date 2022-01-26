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
