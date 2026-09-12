# Network Diagnostic Toolkit



## Deskripsi

Network Diagnostic Toolkit adalah script PowerShell yang dibuat untuk membantu IT Support melakukan pemeriksaan dasar kondisi jaringan pada komputer Windows.

Tool ini melakukan beberapa pemeriksaan jaringan secara otomatis dan memberikan diagnosis awal berdasarkan hasil setiap pemeriksaan.



## Tujuan

Membantu proses troubleshooting IT Support dengan melakukan pemeriksaan secara otomatis terhadap:

* Network adapter
* IP configuration
* Default gateway
* Gateway connectivity
* Internet connectivity
* DNS resolution
* Port connectivity
* Diagnosis dasar
* Pembuatan diagnostic report



## Fitur



### 1\. Network Adapter Check

Memeriksa apakah network adapter yang memiliki konfigurasi default gateway tersedia.

Tool memberikan status:

* OK
* FAILED



### 2\. IP Configuration Check

Memeriksa apakah komputer memiliki IPv4 address pada network interface yang digunakan.

Tool memberikan status:

* OK
* FAILED



### 3\. Default Gateway Check

Memeriksa apakah komputer memiliki default gateway.

Tool memberikan status:

* OK
* FAILED



### 4\. Gateway Connectivity Check

Melakukan pengujian konektivitas ke default gateway menggunakan ICMP ping.

Tool memberikan status:

* OK
* FAILED

Jika gateway tidak dapat dijangkau, tool memberikan indikasi kemungkinan masalah pada jaringan lokal atau router.



### 5\. Internet Connectivity Check

Melakukan pengujian konektivitas internet menggunakan ICMP ke:

`8.8.8.8`

Tool memberikan status:

* OK
* FAILED

Jika gateway dapat dijangkau tetapi koneksi internet gagal, tool memberikan indikasi kemungkinan masalah pada koneksi internet atau upstream network.



### 6\. DNS Resolution Check

Melakukan pengujian DNS resolution terhadap:

`google.com`

Tool menggunakan `Resolve-DnsName` untuk memeriksa apakah domain dapat diterjemahkan menjadi alamat IP.

Tool memberikan status:

* OK
* FAILED

Jika koneksi internet berhasil tetapi DNS resolution gagal, tool memberikan indikasi kemungkinan masalah DNS configuration atau DNS server.



### 7\. Port Connectivity Check

Melakukan pengujian koneksi TCP terhadap:

`google.com:443`

Tool menggunakan `Test-NetConnection` untuk memeriksa konektivitas ke port HTTPS.

Tool memberikan status:

* OK
* FAILED

Jika DNS berhasil tetapi koneksi ke port 443 gagal, tool memberikan indikasi kemungkinan firewall atau network filtering.



### 8\. Automatic Diagnosis

Hasil dari setiap pemeriksaan dikumpulkan dan dianalisis.

Jika ditemukan masalah, tool memberikan warning berdasarkan jenis kegagalan.

Contoh:

`WARNING - Gateway cannot be reached.`

atau:

`WARNING - DNS resolution failed.`

Jika seluruh pemeriksaan dasar berhasil:

`Diagnosis: No basic network issue found.`



### 9\. Diagnostic Report

Tool membuat file:

`NetworkDiagnosticReport.txt`

Report berisi:

* Diagnostic time
* Computer name
* IPv4 address
* Default gateway
* Gateway connectivity
* Internet connectivity
* DNS resolution
* Port 443 connectivity
* Diagnosis



## Teknologi

* PowerShell
* Windows PowerShell Networking
* ICMP
* DNS Resolution
* TCP Port Connectivity



## Cara Menjalankan

1. Buka PowerShell.
2. Masuk ke folder project.
3. Jalankan script:
powershell
./NetworkDiagnostic.ps1



## Struktur Project

IT-Support-Portofolio/Network-Diagnostic/
│
├── NetworkDiagnostic.ps1
├── NetworkDiagnosticReport.txt
├── Readme.md
│
├── screenshots/
│   ├── test-case-1.png
│   ├── test-case-2.png
│   ├── test-case-3.png
│   ├── test-case-4.png
│   ├── test-case-5.png
│   └── test-case-6.png
│
└── test-cases/
└── network-diagnostic-test-case.md

