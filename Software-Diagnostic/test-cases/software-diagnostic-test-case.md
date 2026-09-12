## Test Case 1 - Normal Condition

|Item|Detail|
|-|-|
|Skenario|Komputer dalam kondisi normal|
|Input|required-applications.txt dan required-services.txt valid|
|Expected Result|Tidak ada major issue|
|Result|PASS|

### Expected Output

* Application check berjalan
* Service check berjalan
* CPU Status NORMAL
* Memory Status NORMAL
* Disk Status NORMAL
* Diagnosis menunjukkan tidak ada major issue



## Test Case 2 - Application Tidak Terinstall

|Item|Detail|
|-|-|
|Skenario|Application yang diwajibkan tidak tersedia|
|Input|Application ditambahkan ke required-applications.txt|
|Expected Result|Application berstatus NOT INSTALLED dan warning muncul|
|Result|PASS|

### Expected Output

* Application berstatus NOT INSTALLED
* Warning application ditampilkan pada diagnosis



## Test Case 3 - Required Service Berhenti

|Item|Detail|
|-|-|
|Skenario|Required service dalam kondisi STOPPED|
|Input|Service yang dibutuhkan tercantum di required-services.txt|
|Expected Result|Service berstatus STOPPED dan warning muncul|
|Result|PASS|

### Expected Output

* Service berstatus STOPPED
* Warning service ditampilkan pada diagnosis



## Test Case 4 - Invalid Application Configuration

|Item|Detail|
|-|-|
|Skenario|Format application configuration tidak lengkap|
|Input|Application entry hanya memiliki 2 field|
|Expected Result|CONFIGURATION ERROR ditampilkan|
|Result|PASS|

### Expected Output

* CONFIGURATION ERROR ditampilkan
* Invalid application entry ditampilkan
* Format yang benar ditampilkan:



ApplicationName|RegistryPattern|ProcessName



## Test Case 5 - Invalid Service Configuration

|Item|Detail|
|-|-|
|Skenario|Format service configuration tidak lengkap|
|Input|Service entry hanya memiliki 1 field|
|Expected Result|CONFIGURATION ERROR ditampilkan|
|Result|PASS|

### Expected Output

* CONFIGURATION ERROR ditampilkan
* Invalid service entry ditampilkan
* Format yang benar ditampilkan:



DisplayName|ServiceName



## Test Case 6 - Diagnostic Report

|Item|Detail|
|-|-|
|Skenario|Script selesai menjalankan diagnostic|
|Input|Menjalankan SoftwareDiagnostic.ps1|
|Expected Result|SoftwareDiagnosticReport.txt berhasil dibuat|
|Result|PASS|

### Expected Output

* File SoftwareDiagnosticReport.txt berhasil dibuat
* Diagnostic Time tercatat
* Computer Name tercatat
* Application Issues tercatat
* Service Issues tercatat
* CPU Status tercatat
* Memory Status tercatat
* Disk Status tercatat
* Diagnosis tercatat

