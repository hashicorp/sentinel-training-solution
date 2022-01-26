## Exercise 1

# restrict-vault-auth-methods.sentinel
# This policy restricts which Vault auth methods can be created

# Import common-functions/tfplan-functions/tfplan-functions.sentinel
# with alias "plan"
import "tfplan-functions" as plan

# Allowed Vault Auth Methods
allowed_methods = [
  "<method1>",
  "<method2>",
  "<method3>",
  "<method4>",
]

# Get all Vault auth methods
allVaultAuthMethods = plan.find_resources("<resource_type>")

# Filter to Vault auth methods with violations
# Prints warnings for all violations
violatingVaultAuthMethods = plan.filter_attribute_not_in_list(allVaultAuthMethods,
                            "<attribute>", <list>, true)

# Count violations
violations = length(violatingVaultAuthMethods["messages"])

# Main rule
main = rule {
  violations is 0
}




















## Exercise 2a

# require-access-keys-use-pgp-a.sentinel
# This policy requires AWS IAM access keys to use PGP keys

# Import common-functions/tfplan-functions/tfplan-functions.sentinel
# with alias "plan"
import "tfplan-functions" as plan

# Get all AWS IAM access keys
allIAMAccessKeys = plan.find_resources("<resource_type>")

# Filter to AWS IAM access keys with violations
# The called function prints warnings for all violations
violatingIAMAccessKeys = plan.filter_attribute_does_not_have_prefix(
                         allIAMAccessKeys, "<attribute>", "keybase:", true)

# Count violations
violations = length(violatingIAMAccessKeys["messages"])

# Main rule
main = rule {
  <condition>
}



























## Exercise 2b

# require-access-keys-use-pgp-b.sentinel
# This policy requires AWS IAM access keys to use PGP keys

# Import common-functions/tfplan-functions/tfplan-functions.sentinel
# with alias "plan"
import "tfplan-functions" as plan

# Standard strings import
import "strings"

# Get all AWS IAM access keys
allIAMAccessKeys = plan.find_resources("aws_iam_access_key")

# Filter to AWS IAM access keys with violations
violatingIAMAccessKeys = {}
for allIAMAccessKeys as address, key {
  # Set the pgp_key variable, but set to null if undefined
  pgp_key = key.change.after.pgp_key <expression>
  # First, check if pgp_key is missing or null
  # Second, check if pgp_key does not start with "keybase:"
  # Add violators to violatingIAMAccessKeys and print warnings
  if <condition_1> {
    violatingIAMAccessKeys[address] = key
    print(address, "does not have the pgp_key attribute set")
  } else if <condition_2> {
    violatingIAMAccessKeys[address] = key
    print(address, "has attribute pgp_key with value", pgp_key,
          "that does not start with 'keybase:'")
  }
}

# Count violations
violations = length(violatingIAMAccessKeys)

# Main rule
main = rule {
  violations is 0
}


















## Exercise 3a

# restrict-acm-certificate-domains-a.sentinel
# This policy uses the tfstate import to restrict ACM certificates
# to have domains that are sub-domains of hashidemos.io

# Import common-functions/tfstate-functions/tfstate-functions.sentinel
# with alias "state"
import "tfstate-functions" as state

# Get all AWS ACM certs
allACMCerts = state.find_datasources("<data_source_type>")

# Filter to ACM certs that are not sub-domains of hashidemos.io
violatingACMCerts = filter allACMCerts as address, cert {
  cert.values.<attribute> else "" not matches "(.+)\\.hashidemos\\.io$" and
  print(address, "has domain", <expression>,
        "that is not a sub-domain of hashidemos.io")
}

# Count violations
violations = length(violatingACMCerts)

# Main rule that evaluates the result of the validation function
main = rule {
  violations is 0
}





















## Exercise 3b

# restrict-acm-certificate-domains-b.sentinel
# This policy uses the tfstate import to restrict ACM certificates
# to have domains that are sub-domains of hashidemos.io

# Import common-functions/tfstate-functions/tfstate-functions.sentinel
# with alias "state"
import "tfstate-functions" as state

# Get all AWS ACM certs
allACMCerts = state.find_datasources("aws_acm_certificate")

# Function that validates ACM certs
validate_certs = func(certs, parent_domain) {

  validated = true

  # Loop through the data source instances
  for certs as address, cert {
    # Validate that the domain is sub-domain of parent_domain
    # Use the matches operator
    domain = <expression>
    # Check if domain is sub-domain of parent domain, using the matches operator
    if <condition> {
      print(address, "has domain", domain,
            "that matches the regex", parent_domain)
    } else {
      print(address, "has domain", domain,
            "that does not match the regex", parent_domain, "or is missing")
      validated = false
    }
  }

  return validated

}

# Call the validation function
# Pass it a list of ACM certs and a regex to match
certs_validated = validate_certs(allACMCerts, "<regex>")

# Main rule that evaluates the result of the validation function
main = rule {
  certs_validated
}






## Exercise 4a

# restrict-gcp-instance-image-a.sentinel
# This policy restricts the public images that GCP compute instances use

# Import common-functions/tfplan-functions/tfplan-functions.sentinel
# with alias "plan"
import "tfplan-functions" as plan

# Get all GCP compute instances
allGCPComputeInstances = plan.find_resources("<resource_type>")

# Filter to GCP compute instances with violations
# Prints warnings for all violations
violatingGCPComputeInstances =
  plan.filter_attribute_is_not_value(allGCPComputeInstances,
  "<expression_1>", "debian-cloud/debian-9", true)

# Count violations
violations = <expression_2>

# Main rule
main = rule {
  violations is 0
}



























## Exercise 4b

# restrict-gcp-instance-image-b.sentinel
# This policy restricts the public images that GCP compute instances use
# Import common-functions/tfplan-functions/tfplan-functions.sentinel
# with alias "plan"
import "tfplan-functions" as plan
# Standard types import
import "types"
# Get all GCP compute instances
allGCPComputeInstances = plan.find_resources("google_compute_instance")
# Function to restrict images used by GCP compute instances
filter_images = func(instances, image) {
  # Create empty list of violators
  violators = {}
  # Iterate over instances to check their images
  for instances as address, instance {
    # Set boot_disk variable
    boot_disk = <expression_1>
    # Validate that the initialize_params block is present and a list
    # and that the image under it is allowed
    # Add violators to the violators list and print warnings
    if types.type_of(<expression_2>) is not "list" {
      violators[address] = instance
      print(address, "does not have image defined: it should be", image)
    } else if <expression_3> is not image {
      violators[address] = instance
      print(address, "has image", <expression_3>,
            "but is supposed to use", image)
    } // end if
  } // end for
  return violators
}
# Filter to violating GCP instances
violatingGCPComputeInstances = filter_images(allGCPComputeInstances, "debian-cloud/debian-9")
# Count violations
violations = length(violatingGCPComputeInstances)
# Main rule
<add_main_rule>












## Exercise 5a

# require-modules-from-pmr-a.sentinel
# This policy validates that all modules loaded directly by the
# root module are in the Private Module Registry (PMR) of a TFC
# organization.
# Import the v2 tfplan import, but use the alias "tfplan"
import "tfconfig/v2" as tfconfig
# Standard strings import
import "strings"
##### Parameters #####
# The address of the TFC or TFE server
param address default "app.terraform.io"
# The organization on the TFC or TFE server
param organization
# Require all modules directly under root module to come from PMR
require_modules_from_pmr = func(tf_address, tf_org) {
  validated = true
  # Iterate over all modules but focus on calls from the root module.
  # A module call represents one module referencing another module
  # with a module block.
  for <expression_1> as index, mc {
    # Ignore modules with index matching "<address>:<name>"
    # since these are not called from the root module.
    if <condition_1> {
      if not <condition_2> {
        print("Your root module called the module", index, "with source", <expression_2>)
        validated = false
      } // end second if
    } // end first if
  } // end for
  if not validated {
    print("All modules called from the root module must come from the",
          "private module registry", tf_address + "/" + tf_org)
  }
  return validated
}
# Call the validation function
modules_from_pmr = <function>(<arg1>, <arg2>)
# Main rule
main = rule {
  modules_from_pmr
}











## Exercise 5b

# require-modules-from-pmr-b.sentinel
# This policy validates that all modules loaded directly by the
# root module are in the Private Module Registry (PMR) of a TFC
# organization.

# Import module-functions.sentinel as "modules"
<import_statement>

##### Parameters #####
# The address of the TFC or TFE server
param address default "app.terraform.io"

# The organization on the TFC or TFE server
param organization

# Call the validation function
modules_from_pmr = <function_call>

# Main rule
main = rule {
  modules_from_pmr
}

## Extra credit

# prevent-auto-apply-in-production.sentinel
# This policy uses the Sentinel tfrun import to prevent the use of auto-apply
# in workspaces with names matching "^prod-(.*)" or "(.*)-prod$"

##### Imports #####

import "tfrun"
import "strings"

##### Functions #####

# Validate that auto-apply not set for production workspaces
validate_auto_apply = func() {

  validated = true

  if <condition_1> or
     <condition_2> {
    if <condition_3> {
      print("The workspace", <expression_1>, "has auto_apply set to true")
      validated = false
    }
  }

  return validated
}

##### Rules #####

# Call the validation function
auto_apply_validated = validate_auto_apply()

# Main rule
main = rule {
  auto_apply_validated
}
