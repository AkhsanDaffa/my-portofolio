# Docker Compose vs Kubernetes Commands Cheatsheet

## 🚀 Dasar - Start/Stop Services

| Actions | Docker Compose | Kubernetes |
|---------|----------------|------------|
| **Start** | `docker compose up -d` | `kubectl apply -f deployment.yaml` |
| **Stop** | `docker compose down` | `kubectl delete -f deployment.yaml` |
| **Restart** | `docker compose restart` | `kubectl rollout restart deployment/<name>` |
| **View Status** | `docker compose ps` | `kubectl get pods` |

---

## 📊 Melihat Status

| Actions | Docker Compose | Kubernetes |
|---------|----------------|------------|
| **List services** | `docker compose ps` | `kubectl get pods` |
| **List services (detail)** | `docker compose ps -a` | `kubectl get pods -o wide` |
| **View logs** | `docker compose logs -f` | `kubectl logs -f <pod-name>` |
| **Describe resource** | ❌ Tidak ada | `kubectl describe pod <name>` |
| **View all resources** | `docker compose ps -a` | `kubectl get all` |

---

## 🔧 Troubleshooting

| Actions | Docker Compose | Kubernetes |
|---------|----------------|------------|
| **Exec into container** | `docker compose exec <service> sh` | `kubectl exec -it <pod-name> -- sh` |
| **View events** | ❌ Tidak ada | `kubectl get events` |
| **Debug node** | `docker stats` | `kubectl top nodes` |
| **Debug pod** | `docker stats <container>` | `kubectl top pod` |

---

## ⚙️ Update/Deploy

| Actions | Docker Compose | Kubernetes |
|---------|----------------|------------|
| **Apply config** | `docker compose up -d` | `kubectl apply -f file.yaml` |
| **Scale** | `docker compose up -d --scale <service>=3` | `kubectl scale deployment/<name> --replicas=5` |
| **Rollback** | `docker compose down && docker compose up -d` | `kubectl rollout undo deployment/<name>` |

---

## 🗑️ Cleanup

| Actions | Docker Compose | Kubernetes |
|---------|----------------|------------|
| **Remove containers** | `docker compose down` | `kubectl delete deployment/<name>` |
| **Remove volumes** | `docker compose down -v` | `kubectl delete pvc <name>` |
| **Remove everything** | `docker compose down -v --rmi all` | `kubectl delete namespace <ns>` |

---

## 🔑 Istilah Penting

| Docker Compose | Kubernetes | Keterangan |
|----------------|------------|------------|
| Service | Pod | 1 unit aplikasi |
| docker-compose.yml | deployment.yaml | File konfigurasi |
| Image | Image | Container template |
| Port | Service/Ingress | Akses dari luar |
| Volume | PersistentVolume | Data yang persist |
| Network | CNI (Network Plugin) | Koneksi antar container |

---

## 💡 Contoh Langsung

### Docker Compose (Portfolio Dev)
```bash
# Start development server
docker compose -f docker-compose.dev.yml up

# View logs
docker compose logs -f

# Stop
docker compose down
```

### Kubernetes (Production)
```bash
# Lihat semua pod
kubectl get pods

# Lihat logs aplikasi tertentu
kubectl logs -f deployment/my-app

# Deploy/update aplikasi
kubectl apply -f deployment.yaml

# Scale aplikasi ke 3 replica
kubectl scale deployment/my-app --replicas=3

# Delete aplikasi
kubectl delete -f deployment.yaml
```

---

## 🎯 Perbedaan Utama

| Aspek | Docker Compose | Kubernetes |
|-------|----------------|------------|
| **Kompleksitas** | Simpel | Complex |
| **Scope** | 1 host | Multi-node cluster |
| **Scaling** | Manual | Auto (HPA) |
| **Self-healing** | Tidak | Ya |
| **Use Case** | Dev/Small scale | Production/Large scale |

---

*Cheatsheet untuk portfolio DevOps - Akhsan Daffa*
