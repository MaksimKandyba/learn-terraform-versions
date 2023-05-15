terraform {
  required_providers {
    fly = {
      source  = "fly-apps/fly"
      version = "~> 0.0.21"
    }

    random = {
      version = ">= 2.1.2"
    }
  }

  required_version = "~> 1.4.6"
}

provider "fly" {
  fly_http_endpoint = "api.machines.dev"
}

provider "random" {}

resource "random_pet" "name" {}

resource "fly_app" "exampleApp" {
  name = "kandyba-flyiac"
  org  = "personal"
}

resource "fly_ip" "exampleIp" {
  app        = "kandyba-flyiac"
  type       = "v4"
  depends_on = [fly_app.exampleApp]
}

resource "fly_ip" "exampleIpv6" {
  app        = "kandyba-flyiac"
  type       = "v6"
  depends_on = [fly_app.exampleApp]
}

resource "fly_machine" "web" {
  app    = "kandyba-flyiac"
  region = "ams"
  name   = random_pet.name.id
  image  = "amazonlinux:learn-terraform-versions"
  services = [
    {
      ports = [
        {
          port     = 443
          handlers = ["tls", "http"]
        },
        {
          port     = 80
          handlers = ["http"]
        }
      ]
      "protocol" : "tcp",
      "internal_port" : 80
    },
  ]
  cpus       = 1
  memorymb   = 256
  depends_on = [fly_app.exampleApp]
}
