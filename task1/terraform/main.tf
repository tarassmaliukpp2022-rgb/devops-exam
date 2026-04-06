provider "digitalocean" {
  token             = var.do_token
  spaces_access_id  = var.spaces_access_key
  spaces_secret_key = var.spaces_secret_key
}

# ──────────────────────────────────────────
# VPC
# ──────────────────────────────────────────
resource "digitalocean_vpc" "main" {
  name     = "${var.prefix}-vpc"
  region   = var.region
  ip_range = "10.10.10.0/24"
}

# ──────────────────────────────────────────
# SSH ключ
# ──────────────────────────────────────────
resource "digitalocean_ssh_key" "main" {
  name       = "${var.prefix}-ssh-key"
  public_key = var.ssh_public_key
}

# ──────────────────────────────────────────
# Firewall
# ──────────────────────────────────────────
resource "digitalocean_firewall" "main" {
  name = "${var.prefix}-firewall"

  droplet_ids = [digitalocean_droplet.main.id]

  # Inbound: порти 22, 80, 443, 8000-8003
  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "8000"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "8001"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "8002"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "8003"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  # Outbound: всі порти
  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

# ──────────────────────────────────────────
# Droplet (ВМ)
# Minikube вимагає мінімум: 2 CPU, 2GB RAM
# s-2vcpu-4gb: 2 vCPU, 4 GB RAM — достатньо
# ──────────────────────────────────────────
resource "digitalocean_droplet" "main" {
  name     = "${var.prefix}-node"
  region   = var.region
  size     = "s-2vcpu-4gb"
  image    = "ubuntu-24-04-x64"
  vpc_uuid = digitalocean_vpc.main.id
  ssh_keys = [digitalocean_ssh_key.main.id]

  tags = [var.prefix]
}

# ──────────────────────────────────────────
# Spaces Bucket (object storage)
# ──────────────────────────────────────────
resource "digitalocean_spaces_bucket" "main" {
  name   = "${var.prefix}-bucket"
  region = var.region
  acl    = "private"
}
