---
name: project-talos-migration
description: Homelab rebuild to Talos Linux, cluster status and deployed services
metadata:
  type: project
---

Talos v1.13.6 single-node cluster running at 192.168.178.90 (metal0), Kubernetes v1.33.2.

**Why:** Rebuilding homelab from k3s/Fedora/Ansible to Talos+GitOps for reproducibility.

**How to apply:** All platform and app changes deploy via GitHub Actions CI/CD on push to master. Runner runs in-cluster (actions-runner-system namespace).

## Deployed services
- **MetalLB** — LoadBalancer IP pool 192.168.178.224/27, but ARP not working; Traefik uses externalIPs: 192.168.178.90 as workaround
- **Traefik** — Ingress controller, accessible via 192.168.178.90 (FritzBox port 80/443 forwarded here)
- **cert-manager** — v1.21.0, DNS-01 via INWX webhook (bitte-ein-bit fork), recursive nameservers 8.8.8.8
- **cert-manager-webhook-inwx** — groupName: cert-manager-webhook-inwx.bitte-ein-bit.github.com
- **local-path-provisioner** — default StorageClass for PVCs
- **External Secrets Operator** — v0.10.2, connected to Vaultwarden via bitwardensecretsmanager provider
- **Vaultwarden** — at vault.lab.tanku.eu, organization "homelab" (id: c689a7bb-22c7-40c0-87af-309a7f2ba168)
- **Kanidm** — auth.lab.tanku.eu, TLS certificate pending

## DNS
- Domain: lab.tanku.eu at INWX (user: jon_hecke)
- *.lab is an A record pointing to 87.183.243.230 (external IP)
- FritzBox 7490 forwards port 80+443 to 192.168.178.224

## Known issues
- MetalLB L2 ARP not working on Talos (workaround: Traefik externalIPs)
- Namespace PodSecurity must be set to privileged for: traefik, vaultwarden, metallb-system, local-path-storage, kanidm

## Next steps
1. Kanidm TLS certificate (pending)
2. Kanidm admin initialization (kubectl exec needed once)
3. PostgreSQL + Redis (shared)
4. Nextcloud + OnlyOffice
5. Paperless NGX
6. Immich
7. Matrix
8. Grafana
9. Homepage
