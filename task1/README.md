# Task 1 — Terraform + GitHub Actions + DigitalOcean

## Що розгортається
| Ресурс | Назва | Деталі |
|--------|-------|--------|
| VPC | smaliuk-vpc | 10.10.10.0/24, регіон fra1 (Frankfurt) |
| Firewall | smaliuk-firewall | in: 22,80,443,8000-8003 / out: 1-65535 |
| Droplet | smaliuk-node | 2vCPU/4GB RAM, Ubuntu 24.04 |
| Bucket | smaliuk-bucket | DigitalOcean Spaces, fra1 |

> Регіон `fra1` (Frankfurt) — найближчий до України серед доступних у DigitalOcean.

## tfstate
Зберігається у DigitalOcean Spaces: `smaliuk-bucket/terraform/task1/terraform.tfstate`

## Необхідні GitHub Secrets
Додай у Settings → Secrets → Actions:

| Secret | Опис |
|--------|------|
| `DO_TOKEN` | DigitalOcean API Token |
| `SPACES_ACCESS_KEY` | Spaces Access Key |
| `SPACES_SECRET_KEY` | Spaces Secret Key |
| `SSH_PUBLIC_KEY` | Публічний SSH ключ (~/.ssh/id_rsa.pub) |

## Як отримати ключі DigitalOcean
1. **DO_TOKEN**: https://cloud.digitalocean.com/account/api/tokens → Generate New Token
2. **Spaces Keys**: https://cloud.digitalocean.com/account/api/tokens → Spaces access keys

## Важливо: підготовка bucket для tfstate
Перед першим запуском pipeline потрібно вручну створити Spaces bucket `smaliuk-bucket` у регіоні `fra1` через DigitalOcean UI (або doctl), оскільки він використовується як backend для tfstate.

## Pipelines
- **terraform-apply.yml** — запускається при push у `main` або вручну
  - `terraform validate` → `terraform plan` → `terraform apply`
  - Якщо `plan` завершується з помилкою — pipeline зупиняється ✋
- **terraform-destroy.yml** — тільки ручний запуск (бонус ⭐)
  - Потрібно ввести слово `destroy` для підтвердження
