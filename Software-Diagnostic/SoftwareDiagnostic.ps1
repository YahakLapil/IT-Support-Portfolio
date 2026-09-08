Write-Host "========================================"
Write-Host "       SOFTWARE DIAGNOSTIC TOOL"
Write-Host "========================================"

$requiredServices = Get-Content ".\required-services.txt"
$requiredApps = Get-Content ".\required-applications.txt"

$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$computerName = $env:COMPUTERNAME

function Test-ApplicationInstalled {
    param (
        [string]$RegistryPattern
    )

    $registryPaths = @(
        "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*",
        "HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*",
        "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*"
    )

    foreach ($path in $registryPaths) {
        $app = Get-ItemProperty -Path $path -ErrorAction SilentlyContinue |
               Where-Object {
                   $_.DisplayName -like "*$RegistryPattern*"
               }

        if ($app) {
            return $true
        }
    }

    return $false
}

$applicationIssues = @()

Write-Host ""
Write-Host "[APPLICATION CHECK]"

foreach ($line in $requiredApps) {

    if ([string]::IsNullOrWhiteSpace($line)) {
        continue
    }

    $parts = $line -split "\|"

    if ($parts.Count -ne 3) {
        Write-Host ""
        Write-Host "CONFIGURATION ERROR"
        Write-Host "Invalid application entry: $line"
        Write-Host "Expected format: ApplicationName|RegistryPattern|ProcessName"
        continue
    }

    $applicationName = $parts[0]
    $registryPattern = $parts[1]
    $processName = $parts[2]

    $installed = Test-ApplicationInstalled $registryPattern

    if ($installed) {

    $running = Get-Process -Name $processName -ErrorAction SilentlyContinue

    if ($running) {
        Write-Host "$applicationName : INSTALLED / RUNNING"
    }
    else {
        Write-Host "$applicationName : INSTALLED / NOT RUNNING"
    }

    }
    else {
    Write-Host "$applicationName : NOT INSTALLED"
    $applicationIssues += "$applicationName is not installed."
    }
}

$serviceIssues = @()

Write-Host ""
Write-Host "[SERVICE CHECK]"

$serviceIssues = @()

foreach ($line in $requiredServices) {

    if ([string]::IsNullOrWhiteSpace($line)) {
        continue
    }

    $parts = $line -split "\|"

    if ($parts.Count -ne 2) {
        Write-Host ""
        Write-Host "CONFIGURATION ERROR"
        Write-Host "Invalid service entry: $line"
        Write-Host "Expected format: DisplayName|ServiceName"
        continue
    }

    $serviceDisplayName = $parts[0]
    $serviceName = $parts[1]

    try {
        $service = Get-Service -Name $serviceName -ErrorAction Stop

        if ($service.Status -eq "Running") {
            Write-Host "$serviceDisplayName : RUNNING"
        }
        else {
            Write-Host "$serviceDisplayName : STOPPED"
            $serviceIssues += "$serviceDisplayName is not running."
        }
    }
    catch {
        Write-Host "$serviceDisplayName : NOT FOUND"
        $serviceIssues += "$serviceDisplayName was not found."
    }
}

Write-Host ""
Write-Host "[MEMORY CHECK]"

$os = Get-CimInstance Win32_OperatingSystem

$totalMemory = $os.TotalVisibleMemorySize
$freeMemory = $os.FreePhysicalMemory

$memoryUsage = (($totalMemory - $freeMemory) / $totalMemory) * 100
$memoryUsage = [math]::Round($memoryUsage, 0)

Write-Host "Memory Usage : $memoryUsage%"

$memoryOK = $false

if ($memoryUsage -lt 80) {
    Write-Host "Memory Status : NORMAL"
    $memoryOK = $true
}
else {
    Write-Host "Memory Status : HIGH"
}

Write-Host ""
Write-Host "[CPU CHECK]"

$cpuUsage = (Get-Counter '\Processor(_Total)\% Processor Time').CounterSamples.CookedValue
$cpuUsage = [math]::Round($cpuUsage, 0)

Write-Host "CPU Usage : $cpuUsage%"

$cpuOK = $false

if ($cpuUsage -lt 80) {
    Write-Host "CPU Status : NORMAL"
    $cpuOK = $true
}
else {
    Write-Host "CPU Status : HIGH"
}

Write-Host ""
Write-Host "[DISK CHECK]"

$disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"

$freeDiskGB = $disk.FreeSpace / 1GB
$freeDiskGB = [math]::Round($freeDiskGB, 1)

Write-Host "Free Disk Space : $freeDiskGB GB"

$diskOK = $false

if ($freeDiskGB -gt 10) {
    Write-Host "Disk Status : NORMAL"
    $diskOK = $true
}
else {
    Write-Host "Disk Status : LOW"
}

$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

Write-Host ""
Write-Host "[DIAGNOSIS]"

$issueFound = $false

foreach ($issue in $applicationIssues) {
    Write-Host "WARNING - $issue"
    $issueFound = $true
}

foreach ($issue in $serviceIssues) {
    Write-Host "WARNING - $issue"
    $issueFound = $true
}

if (-not $memoryOK) {
    Write-Host "WARNING - High memory usage detected."
    $issueFound = $true
}

if (-not $cpuOK) {
    Write-Host "WARNING - High CPU usage detected."
    $issueFound = $true
}

if (-not $diskOK) {
    Write-Host "WARNING - Low disk space detected."
    $issueFound = $true
}

if (-not $issueFound) {
    Write-Host "No major software issue detected."
}

$report = @"
========================================
       SOFTWARE DIAGNOSTIC REPORT
========================================

Diagnostic Time : $timestamp
Computer Name   : $computerName

[APPLICATION ISSUES]
"@

if ($applicationIssues.Count -eq 0) {
    $report += "`nNo application issue detected."
}
else {
    foreach ($issue in $applicationIssues) {
        $report += "`nWARNING - $issue"
    }
}

$report += @"

[SERVICE ISSUES]
"@

if ($serviceIssues.Count -eq 0) {
    $report += "`nNo service issue detected."
}
else {
    foreach ($issue in $serviceIssues) {
        $report += "`nWARNING - $issue"
    }
}

$report += @"

[RESOURCE STATUS]

CPU Usage       : $cpuUsage%
Memory Usage    : $memoryUsage%
Free Disk Space : $freeDiskGB GB
"@

if ($cpuOK) {
    $report += "`nCPU Status      : NORMAL"
}
else {
    $report += "`nCPU Status      : HIGH"
}

if ($memoryOK) {
    $report += "`nMemory Status   : NORMAL"
}
else {
    $report += "`nMemory Status   : HIGH"
}

if ($diskOK) {
    $report += "`nDisk Status     : NORMAL"
}
else {
    $report += "`nDisk Status     : LOW"
}

$report += @"

[DIAGNOSIS]
"@

if (-not $issueFound) {
    $report += "`nNo major software issue detected."
}
else {
    $report += "`nAttention required. Review the warnings above."
}

$report += @"

========================================
       END OF DIAGNOSTIC REPORT
========================================
"@

$report | Out-File ".\SoftwareDiagnosticReport.txt" -Encoding UTF8

Write-Host ""
Write-Host "Report saved to:"
Write-Host ".\SoftwareDiagnosticReport.txt"