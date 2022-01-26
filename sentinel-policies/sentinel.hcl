module "tfplan-functions" {
    source = "./common-functions/tfplan-functions/tfplan-functions.sentinel"
}

module "tfstate-functions" {
    source = "./common-functions/tfstate-functions/tfstate-functions.sentinel"
}

module "module-functions" {
    source = "./common-functions/module-functions/module-functions.sentinel"
}

policy "require-even-number" {
    source = "./require-even-number.sentinel"
    enforcement_level = "hard-mandatory"
}

policy "restrict-vault-auth-methods" {
    source = "./restrict-vault-auth-methods.sentinel"
    enforcement_level = "hard-mandatory"
}

policy "require-access-keys-use-pgp-a" {
    source = "./require-access-keys-use-pgp-a.sentinel"
    enforcement_level = "hard-mandatory"
}

policy "require-access-keys-use-pgp-b" {
    source = "./require-access-keys-use-pgp-b.sentinel"
    enforcement_level = "hard-mandatory"
}

policy "restrict-acm-certificate-domains-a" {
    source = "./restrict-acm-certificate-domains-a.sentinel"
    enforcement_level = "hard-mandatory"
}

policy "restrict-acm-certificate-domains-b" {
    source = "./restrict-acm-certificate-domains-b.sentinel"
    enforcement_level = "hard-mandatory"
}

policy "restrict-gcp-instance-image-a" {
    source = "./restrict-gcp-instance-image-a.sentinel"
    enforcement_level = "hard-mandatory"
}

policy "restrict-gcp-instance-image-b" {
    source = "./restrict-gcp-instance-image-b.sentinel"
    enforcement_level = "hard-mandatory"
}

policy "require-modules-from-pmr-a" {
    source = "./require-modules-from-pmr-a.sentinel"
    enforcement_level = "hard-mandatory"
}

policy "require-modules-from-pmr-b" {
    source = "./require-modules-from-pmr-b.sentinel"
    enforcement_level = "hard-mandatory"
}

policy "prevent-auto-apply-in-production" {
    source = "./prevent-auto-apply-in-production.sentinel"
    enforcement_level = "hard-mandatory"
}

