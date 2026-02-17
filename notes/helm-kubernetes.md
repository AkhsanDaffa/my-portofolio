# Helm & Kubernetes Resources Cheatsheet

## 🚀 Helm Commands

### Dasar

| Command | Fungsi |
|---------|--------|
| `helm repo update` | Update repository charts |
| `helm search repo <chart>` | Search chart di repository lokal |
| `helm search hub <chart>` | Search chart di Helm Hub |
| `helm install <name> <chart>` | Install chart baru |
| `helm install <name> <chart> -n <namespace> --create-namespace` | Install ke namespace baru |
| `helm upgrade <name> <chart>` | Update release |
| `helm rollback <name> <revision>` | Rollback ke revision tertentu |
| `helm uninstall <name>` | Remove release |
| `helm list` | List semua releases |
| `helm list -n <namespace>` | List releases di namespace tertentu |
| `helm status <name>` | Status release |
| `helm get values <name>` | Get values yang sedang digunakan |
| `helm get all <name>` | Get semua info release |
| `helm template <chart>` | Render template tanpa install |

### Values & Configuration

| Command | Fungsi |
|---------|--------|
| `helm install <name> <chart> --set key=value` | Override values via CLI |
| `helm install <name> <chart> -f values.yaml` | Override values via file |
| `helm show values <chart>` | Lihat default values |
| `helm pull <chart>` | Download chart saja (tanpa install) |
| `helm pull <chart> --untar` | Download & extract chart |

### Debugging

| Command | Fungsi |
|---------|--------|
| `helm template <chart> -f values.yaml` | Render template locally |
| `helm install --dry-run <name> <chart>` | Test install (dry run) |
| `helm upgrade --dry-run <name> <chart>` | Test upgrade (dry run) |
| `helm lint <chart>` | Validasi chart |

---

## 📊 Prometheus & Grafana Commands

### Install Prometheus Stack

```bash
# Install Prometheus + Grafana
helm install prometheus prometheus-community/kube-prometheus-stack -n monitoring --create-namespace

# Install dengan custom values
helm install prometheus prometheus-community/kube-prometheus-stack \
  -n monitoring \
  --set prometheus.prometheusSpec.retention=15d \
  --set grafana.adminPassword=yourpassword
```

### Manajemen

```bash
# Upgrade
helm upgrade prometheus prometheus-community/kube-prometheus-stack -n monitoring

# Rollback
helm rollback prometheus 1 -n monitoring

# Uninstall
helm uninstall prometheus -n monitoring
```

### Akses Grafana

```bash
# Get Grafana password
kubectl get secret -n monitoring prometheus-grafana -o jsonpath="{.data.admin-password}" | base64 -d

# Port-forward ke Grafana
kubectl port-forward -n monitoring svc/prometheus-grafana 3000:80

# Port-forward ke Prometheus
kubectl port-forward -n monitoring svc/prometheus-prometheus 9090:9090
```

### Monitoring Pods

```bash
# Lihat semua resource di namespace monitoring
kubectl get all -n monitoring

# Lihat pods
kubectl get pods -n monitoring

# Lihat services
kubectl get svc -n monitoring

# Lihat persistent volumes
kubectl get pvc -n monitoring
```

---

## 🔑 Istilah Penting Kubernetes

### Resources Utama

| Istilah | Arti |
|---------|------|
| **Pod** | Unit terkecil di K8s - bisa 1 atau lebih container |
| **Deployment** | Blueprint untuk managing pods (replica, update, rollback) |
| **Service** | Endpoint untuk akses aplikasi (ClusterIP, NodePort, LoadBalancer) |
| **Ingress** | Route HTTP/HTTPS traffic dari luar |
| **ConfigMap** | Konfigurasi non-sensitif |
| **Secret** | Konfigurasi sensitif (password, token, keys) |
| **PV (PersistentVolume)** | Storage persistence |
| **PVC (PersistentVolumeClaim)** | Request storage |
| **Namespace** | Isolasi resource |

### Helm Specific

| Istilah | Arti |
|---------|------|
| **Chart** | Package K8s (seperti apt-get package) |
| **Release** | Instance chart yang ter-install |
| **Repository** | Tempat menyimpan charts |
| **Values** | Konfigurasi untuk customize chart |
| **Template** | Template K8s resources di dalam chart |

### Network

| Istilah | Arti |
|---------|------|
| **Ingress Controller** | pods yang handle ingress traffic (nginx, traefik) |
| **ServiceMonitor** | Konfigurasi Prometheus untuk scrape metrics |
| **Endpoint** | IP + port tujuan |
| **NetworkPolicy** | Aturan koneksi antar pods |

---

## 📝 Contoh Langsung: Install Monitoring Stack

### Step 1: Add Repository
```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
```

### Step 2: Install
```bash
kubectl create namespace monitoring
helm install monitoring prometheus-community/kube-prometheus-stack -n monitoring
```

### Step 3: Akses Grafana
```bash
# Port forward
kubectl port-forward -n monitoring svc/monitoring-grafana 3000:80

# Buka browser: http://localhost:3000
# Default user: admin
# Password: (lihat dengan command di atas)
```

### Step 4: Cek Status
```bash
kubectl get pods -n monitoring
kubectl get svc -n monitoring
kubectl top nodes -n monitoring  # Kalau metrics collector sudah jalan
```

---

## 🔧 Common Helm Charts untuk DevOps

| Chart | Fungsi |
|-------|--------|
| `prometheus-community/kube-prometheus-stack` | Full monitoring (Prometheus + Grafana + AlertManager) |
| `prometheus-community/prometheus` | Prometheus saja |
| `grafana/grafana` | Grafana saja |
| `bitnami/nginx-ingress-controller` | Nginx Ingress |
| `bitnami/postgresql` | PostgreSQL database |
| `bitnami/redis` | Redis cache |
| `bitnami/kafka` | Apache Kafka |
| `jenkins/jenkins` | Jenkins CI/CD |
| `hashicorp/vault` | Secrets management |

---

## 🎯 Perbandingan Helm vs Native K8s

| Task | Helm | Native K8s |
|------|------|------------|
| Install app | `helm install <name> <chart>` | `kubectl apply -f deployment.yaml` |
| Update app | `helm upgrade <name> <chart>` | `kubectl apply -f updated.yaml` |
| Remove app | `helm uninstall <name>` | `kubectl delete -f deployment.yaml` |
| Rollback | `helm rollback <name>` | `kubectl rollout undo` |
| Config | `values.yaml` | Environment variables, ConfigMap |
| Templating | ✅ Built-in | Manual dengan tools lain |

---

*Cheatsheet Helm & Kubernetes - Akhsan Daffa*
