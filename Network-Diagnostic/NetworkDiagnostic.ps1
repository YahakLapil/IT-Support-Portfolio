Write-Host "=================================="
Write-Host "     NETWORK DIAGNOSTIC TOOL"
Write-Host "=================================="

$adapter = (Get-NetIPConfiguration | Select-Object IPv4DefaultGateway).IPv4DefaultGateway.ifIndex
$ip = (Get-NetIPAddress -AddressFamily IPv4 -InterfaceIndex $adapter | Select-Object IPAddress).IPAddress
$gateway = (Get-NetIPConfiguration | Select-Object IPv4DefaultGateway).IPv4DefaultGateway.NextHop
$gatewayTest = Test-Connection $gateway -Count 1 -Quiet
$internetTest = Test-Connection 8.8.8.8 -Count 1 -Quiet
$portTest = Test-NetConnection google.com -Port 443 -InformationLevel Quiet

try {
    Resolve-DnsName google.com -ErrorAction Stop | Out-Null
    $dnsTest = $true
}
catch {
    $dnsTest = $false
}

Write-Host "IPv4 Address: $ip"
Write-Host "Default Gateway: $gateway"
Write-Host ""

if ($adapter -ne $null) {
    Write-Host "[1] Network Adapter : OK"
}
else {
    Write-Host "[1] Network Adapter : FAILED"
}

if ($ip -ne $null) {
    Write-Host "[2] IP Configuration : OK"
}
else {
    Write-Host "[2] IP Configuration : FAILED"
}

if ($gateway -ne $null) {
    Write-Host "[3] Default Gateway : OK"
}
else {
    Write-Host "[3] Default Gateway : FAILED"
}

if ($gatewayTest) {
    Write-Host "[4] Gateway Connectivity : OK"
}
else {
    Write-Host "[4] Gateway Connectivity : FAILED"
}

if ($internetTest) {
    Write-Host "[5] Internet Connectivity : OK"
}
else {
    Write-Host "[5] Internet Connectivity : FAILED"
}

if ($dnsTest) {
    Write-Host "[6] DNS Resolution : OK"
}
else {
    Write-Host "[6] DNS Resolution : FAILED"
}

if ($portTest) {
    Write-Host "[7] Port Connectivity : OK"
}
else {
    Write-Host "[7] Port Connectivity : FAILED"
}

if ($gatewayTest -and $internetTest -and $dnsTest -and $portTest) {
    Write-Host ""
    Write-Host "Diagnosis: No basic network issue found."
}
else {
    Write-Host ""
    Write-Host "Diagnosis:"

    if (-not $gatewayTest) {
        Write-Host "WARNING - Gateway cannot be reached."
        Write-Host "Possible cause: Local network or router connection issue."
    }

    if ($gatewayTest -and -not $internetTest) {
        Write-Host "WARNING - Internet connectivity failed."
        Write-Host "Possible cause: Internet connection or upstream network issue."
    }

    if ($internetTest -and -not $dnsTest) {
        Write-Host "WARNING - DNS resolution failed."
        Write-Host "Possible cause: DNS configuration or DNS server issue."
    }

    if ($dnsTest -and -not $portTest) {
        Write-Host "WARNING - Port 443 connectivity failed."
        Write-Host "Possible cause: Firewall or network filtering issue."
    }
    Write-Host ""
}

$report = @"
==================================
     NETWORK DIAGNOSTIC REPORT
==================================

Diagnostic Time       : $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")
Computer Name         : $env:COMPUTERNAME

IPv4 Address          : $ip
Default Gateway       : $gateway
Gateway Connectivity  : $gatewayTest
Internet Connectivity : $internetTest
DNS Resolution        : $dnsTest
Port 443 Connectivity : $portTest

Diagnosis:
"@

if ($gatewayTest -and $internetTest -and $dnsTest -and $portTest) {
    $report += " No basic network issue found."
}
else {
    if (-not $gatewayTest) {
        $report += "`nWARNING - Gateway cannot be reached."
    }

    if ($gatewayTest -and -not $internetTest) {
        $report += "`nWARNING - Internet connectivity failed."
    }

    if ($internetTest -and -not $dnsTest) {
        $report += "`nWARNING - DNS resolution failed."
    }

    if ($dnsTest -and -not $portTest) {
        $report += "`nWARNING - Port 443 connectivity failed."
    }
}

$report | Out-File ".\NetworkDiagnosticReport.txt" -Encoding UTF8

Write-Host ""
Write-Host "Report saved to:"
Write-Host ".\NetworkDiagnosticReport.txt"