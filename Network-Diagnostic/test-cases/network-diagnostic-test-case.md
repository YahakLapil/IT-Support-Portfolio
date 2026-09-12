## Test Case 1 - Normal Condition

|Item|Detail|
|-|-|
|Skenario|Komputer dalam kondisi normal|
|Input|Komputer terhubung ke jaringan dan konfigurasi jaringan valid|
|Expected Result|Tidak ada basic network issue|
|Result|PASS|

### Expected Output

* Network Adapter berstatus OK
* IP Configuration berstatus OK
* Default Gateway berstatus OK
* Gateway Connectivity berstatus OK
* Internet Connectivity berstatus OK
* DNS Resolution berstatus OK
* Port Connectivity berstatus OK
* Diagnosis menunjukkan tidak ada basic network issue



## Test Case 2 - DNS Bermasalah

|Item|Detail|
|-|-|
|Skenario|DNS resolution tidak dapat dilakukan|
|Input|DNS test menghasilkan FALSE|
|Expected Result|DNS Resolution berstatus FAILED dan warning DNS muncul|
|Result|PASS|

### Expected Output

* DNS Resolution berstatus FAILED
* Warning DNS ditampilkan pada diagnosis
* Diagnosis memberikan indikasi masalah DNS



## Test Case 3 - Gateway Tidak Dapat Diakses

|Item|Detail|
|-|-|
|Skenario|Default Gateway tidak dapat dijangkau|
|Input|Gateway test menghasilkan FALSE|
|Expected Result|Gateway Connectivity berstatus FAILED dan warning gateway muncul|
|Result|PASS|

### Expected Output

* Gateway Connectivity berstatus FAILED
* Warning gateway ditampilkan pada diagnosis
* Diagnosis memberikan indikasi masalah jaringan lokal atau router



## Test Case 4 - Internet Tidak Dapat Diakses

|Item|Detail|
|-|-|
|Skenario|Koneksi internet tidak dapat diakses|
|Input|Internet connectivity test menghasilkan FALSE|
|Expected Result|Internet Connectivity berstatus FAILED dan warning internet muncul|
|Result|PASS|

### Expected Output

* Internet Connectivity berstatus FAILED
* Warning internet ditampilkan pada diagnosis
* Diagnosis memberikan indikasi masalah koneksi internet



## Test Case 5 - Port 443 Tidak Dapat Diakses

|Item|Detail|
|-|-|
|Skenario|Koneksi TCP ke port 443 tidak dapat dilakukan|
|Input|Port 443 connectivity test menghasilkan FALSE|
|Expected Result|Port Connectivity berstatus FAILED dan warning port muncul|
|Result|PASS|

### Expected Output

* Port Connectivity berstatus FAILED
* Warning port 443 ditampilkan pada diagnosis
* Diagnosis memberikan indikasi kemungkinan firewall atau network filtering



## Test Case 6 - Diagnostic Report

|Item|Detail|
|-|-|
|Skenario|Script selesai menjalankan diagnostic|
|Input|Menjalankan NetworkDiagnostic.ps1|
|Expected Result|NetworkDiagnosticReport.txt berhasil dibuat|
|Result|PASS|

### Expected Output

* File NetworkDiagnosticReport.txt berhasil dibuat
* Diagnostic Time tercatat
* Computer Name tercatat
* IPv4 Address tercatat
* Default Gateway tercatat
* Gateway Connectivity tercatat
* Internet Connectivity tercatat
* DNS Resolution tercatat
* Port 443 Connectivity tercatat
* Diagnosis tercatat

