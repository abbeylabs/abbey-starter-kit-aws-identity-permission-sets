terraform {
  required_version = ">= 1.5.7"

  required_providers {
    abbey = {
      source = "abbeylabs/abbey"
    }

    aws = {
      source = "hashicorp/aws"
    }
  }
}
