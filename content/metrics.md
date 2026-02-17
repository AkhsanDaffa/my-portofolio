---
title: "Live Metrics"
date: 2026-02-17
---

Halaman ini menampilkan metrik *live* langsung dari peladen (server) **Raspberry Pi 4B (8GB)** saya yang berada di kamar, dipantau menggunakan Prometheus dan Grafana di dalam klaster Kubernetes (K3s).

> **Note:** Metrik hanya dapat diakses dari jaringan lokal (LAN). Jika Anda mengakses dari luar jaringan, metrik tidak akan muncul.

### 🖥️ Server Specifications

<div class="grid grid-cols-1 md:grid-cols-3 gap-4 my-8">
    <div class="bg-gray-800 p-4 border-l-4 border-green-500">
        <h4 class="font-bold text-white text-sm">Hardware</h4>
        <p class="text-gray-400 text-xs mt-1">Raspberry Pi 4B (8GB RAM)</p>
    </div>
    <div class="bg-gray-800 p-4 border-l-4 border-blue-500">
        <h4 class="font-bold text-white text-sm">Orchestration</h4>
        <p class="text-gray-400 text-xs mt-1">K3s Kubernetes Cluster</p>
    </div>
    <div class="bg-gray-800 p-4 border-l-4 border-purple-500">
        <h4 class="font-bold text-white text-sm">Monitoring</h4>
        <p class="text-gray-400 text-xs mt-1">Prometheus + Grafana</p>
    </div>
</div>

### 📊 CPU & Memory Usage

<div class="grid grid-cols-1 md:grid-cols-2 gap-6 my-8">
    <div class="border border-gray-700 rounded overflow-hidden bg-gray-800/50">
        <div class="bg-gray-800 px-4 py-2 border-b border-gray-700">
            <span class="text-green-400 text-sm font-bold">CPU Usage</span>
        </div>
        <iframe src="http://192.168.0.120:3000/d-solo/7d57716318ee0dddbac5a7f451fb7753/node-exporter-nodes?orgId=1&from=1771296508826&to=1771300108826&timezone=utc&var-datasource=prometheus&var-cluster=$__all&var-instance=192.168.0.120:9100&refresh=30s&panelId=panel-2&__feature.dashboardSceneSolo=true" width="100%" height="200" frameborder="0"></iframe>
    </div>
    <div class="border border-gray-700 rounded overflow-hidden bg-gray-800/50">
        <div class="bg-gray-800 px-4 py-2 border-b border-gray-700">
            <span class="text-blue-400 text-sm font-bold">Memory Usage</span>
        </div>
        <iframe src="http://192.168.0.120:3000/d-solo/7d57716318ee0dddbac5a7f451fb7753/node-exporter-nodes?orgId=1&timezone=utc&var-datasource=prometheus&var-cluster=$__all&var-instance=192.168.0.120:9100&refresh=30s&panelId=panel-5&__feature.dashboardSceneSolo=true" width="100%" height="200" frameborder="0"></iframe>
    </div>
</div>

### 🌐 Network Traffic

<div class="border border-gray-700 rounded overflow-hidden bg-gray-800/50 my-8">
    <div class="bg-gray-800 px-4 py-2 border-b border-gray-700">
        <span class="text-yellow-400 text-sm font-bold">Network I/O</span>
    </div>
    <div class="grid grid-cols-1 md:grid-cols-2 gap-0">
        <iframe src="http://192.168.0.120:3000/d-solo/7d57716318ee0dddbac5a7f451fb7753/node-exporter-nodes?orgId=1&timezone=utc&var-datasource=prometheus&var-cluster=$__all&var-instance=192.168.0.120:9100&refresh=30s&panelId=panel-11&__feature.dashboardSceneSolo=true" width="100%" height="200" frameborder="0"></iframe>
        <iframe src="http://192.168.0.120:3000/d-solo/7d57716318ee0dddbac5a7f451fb7753/node-exporter-nodes?orgId=1&from=1771297884353&to=1771301484353&timezone=utc&var-datasource=prometheus&var-cluster=$__all&var-instance=192.168.0.120:9100&refresh=30s&panelId=panel-12&__feature.dashboardSceneSolo=true" width="100%" height="200" frameborder="0"></iframe>
    </div>
</div>

*Catatan: Jika metrik gagal dimuat, peladen saya mungkin sedang dalam tahap pemeliharaan (maintenance) atau pemadaman listrik lokal.*