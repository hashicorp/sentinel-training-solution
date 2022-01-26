variable "types" {
  description = "types of Vault auth methods"
  type = "list"
}

variable "paths" {
  description = "paths to Vault auth methods"
  type = "list"
}

resource "vault_auth_backend" "test" {
  count = "${length(var.paths)}"
  type = "${var.types[count.index]}"
  path = "${var.paths[count.index]}"
}
