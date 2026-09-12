# Software Diagnostic Toolkit



## Deskripsi

Software Diagnostic Toolkit adalah script PowerShell yang dibuat untuk membantu IT Support melakukan pemeriksaan dasar kondisi software dan resource pada komputer Windows.

Tool ini menggunakan file konfigurasi agar aplikasi dan service yang diperiksa dapat disesuaikan dengan kebutuhan lingkungan kerja.



## Tujuan

Membantu proses troubleshooting IT Support dengan melakukan pemeriksaan secara otomatis terhadap:

* Aplikasi yang dibutuhkan
* Status aplikasi
* Service yang dibutuhkan
* Penggunaan CPU
* Penggunaan memory
* Ruang penyimpanan
* Kondisi konfigurasi
* Diagnosis dasar
* Pembuatan diagnostic report



## Fitur



### 1\. Application Check

Memeriksa aplikasi yang telah ditentukan pada:

`required-applications.txt`

Format konfigurasi:

`ApplicationName|RegistryPattern|ProcessName`

Tool dapat memberikan status:

* INSTALLED / RUNNING
* INSTALLED / NOT RUNNING
* NOT INSTALLED

Aplikasi yang terinstall tetapi sedang tidak digunakan tidak dianggap sebagai masalah.



### 2\. Service Check

Memeriksa service yang ditentukan pada:

`required-services.txt`

Format konfigurasi:

`DisplayName|ServiceName`

Tool memberikan status:

* RUNNING
* STOPPED
* NOT FOUND

Service yang berhenti atau tidak ditemukan akan dimasukkan ke dalam hasil diagnosis apabila service tersebut memang didefinisikan sebagai required service.



### 3\. Memory Check

Menghitung penggunaan memory komputer dan memberikan status:

* NORMAL
* HIGH



### 4\. CPU Check

Memeriksa penggunaan CPU dan memberikan status:

* NORMAL
* HIGH



### 5\. Disk Check

Memeriksa ruang kosong pada drive `C:` dan memberikan status:

* NORMAL
* LOW



### 6\. Configuration Validation

Tool melakukan validasi terhadap format file konfigurasi.

Contoh format aplikasi yang benar:

`Microsoft Edge|Microsoft Edge|msedge`

Contoh format service yang benar:

`Print Spooler|Spooler`

Jika format tidak sesuai, tool menampilkan `CONFIGURATION ERROR`.



### 7\. Automatic Diagnosis

Hasil dari setiap pemeriksaan dikumpulkan dan dianalisis.

Jika ditemukan masalah, tool memberikan warning seperti:

`WARNING - Application is not installed.`

atau:

`WARNING - Service is not running.`

Jika tidak ditemukan masalah:

`No major software issue detected.`



### 8\. Diagnostic Report

Tool membuat file:

`SoftwareDiagnosticReport.txt`

Report berisi:

* Diagnostic time
* Computer name
* Application issues
* Service issues
* CPU status
* Memory status
* Disk status
* Diagnosis



## Teknologi

* PowerShell
* Windows Management Instrumentation (WMI)
* Windows Services
* Windows System Information



## Cara Menjalankan

1. Buka PowerShell.
2. Masuk ke folder project.
3. Pastikan file konfigurasi berikut tersedia:
text
required-applications.txt
required-services.txt
4. Jalankan script:

&#x20;  powershell

&#x20;  ./SoftwareDiagnostic.ps1



## Struktur Project

IT-Support-Portofolio/Software-Diagnostic/
│
├── SoftwareDiagnostic.ps1
├── required-applications.txt
├── required-services.txt
├── SoftwareDiagnosticReport.txt
├── Readme.md
├── screenshots/
│   ├── test-case-1.png
│   ├── test-case-2.png
│   ├── test-case-3.png
│   ├── test-case-4.png
│   ├── test-case-5.png
│   └── test-case-6.png
└── test-cases/
└── software-diagnostic-test-case.md

