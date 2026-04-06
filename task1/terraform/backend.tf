terraform {
  required_version = ">= 1.0"

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }

  # tfstate зберігається у DigitalOcean Spaces (S3-сумісне сховище)
  backend "s3" {
    endpoint = "https://fra1.digitaloceanspaces.com"
    region   = "us-east-1" # фіктивне значення, обов'язкове для S3-backend

    bucket = "smaliuk-bucket"
    key    = "terraform/task1/terraform.tfstate"

    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    force_path_style            = true
  }
}
