# Modern Kubernetes GitOps Infrastructure

Local Kubernetes cluster with GitOps automation, monitoring, logging, and event streaming.

## Infrastructure Components

**GitOps & Automation**
* **FluxCD** - Automatic Git-to-cluster synchronization
* **Helm** - Kubernetes package manager

**Monitoring & Observability**
* **Prometheus** - Metrics collection and storage
* **Grafana** - Metrics visualization and dashboards
* **Fluent-bit** - Log collection and aggregation

**Event Streaming**
* **Kafka (Strimzi)** - Event streaming in KRaft mode (no Zookeeper)
* **KafkaNodePool** - Modern node management for Kafka

**Security & Auth**
* **Keycloak** - Identity and access management

## Tech Stack

* Kubernetes (kind) - Local cluster
* FluxCD v2.7.5 - GitOps operator
* Prometheus Stack v81.2.2
* Fluent-bit v0.55.0
* Kafka v4.1.1 (KRaft mode)
* Keycloak v26.0
* GitHub - Git repository

## Architecture Approach

**GitOps**: Infrastructure as Code with Git as single source of truth. All changes pushed to Git are automatically applied to the cluster.

**Declarative**: All configurations defined in YAML manifests under `clusters/demo-cluster/`.

**Automated Reconciliation**: FluxCD continuously monitors Git repository and syncs cluster state every 1-5 minutes.

## Quick Start
```bash
# Create cluster
kind create cluster --name demo-cluster

# Bootstrap FluxCD
flux bootstrap github \
  --owner=oshevchenko1805 \
  --repository=modern-k8s \
  --branch=main \
  --path=clusters/demo-cluster \
  --personal

# Wait for deployment
kubectl get pods -A
```

## Access Services

**Grafana**: `kubectl port-forward -n monitoring svc/kube-prometheus-stack-grafana 3000:80`
- http://localhost:3000 (admin/admin123)

**Keycloak**: `kubectl port-forward -n keycloak svc/keycloak 8080:8080`
- http://localhost:8080 (admin/admin123)

## Repository Structure
```
clusters/demo-cluster/
├── flux-system/      # FluxCD components
├── monitoring/       # Prometheus + Grafana
├── logging/          # Fluent-bit
├── kafka/            # Kafka with KRaft
└── keycloak/         # Keycloak auth
```

## GitOps Workflow

1. Edit YAML manifests
2. Commit & push to GitHub
3. FluxCD auto-applies changes
4. Verify with `kubectl get pods -A`

## Cleanup
```bash
kind delete cluster --name demo-cluster
```

---

**Author**: [Oleksandra Shevchenko](https://github.com/oshevchenko1805)
