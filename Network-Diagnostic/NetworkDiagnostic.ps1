Write-Host "=================================="
Write-Host "     NETWORK DIAGNOSTIC TOOL"
Write-Host "=================================="

$adapter = (Get-NetIPConfiguration | Select-Object IPv4DefaultGateway).IPv4DefaultGateway.ifIndex
$ip = (Get-NetIPAddress -AddressFamily IPv4 -InterfaceIndex $adapter | Select-Object IPAddress).IPAddress
$gateway = (Get-NetIPConfiguration | Select-Object IPv4DefaultGateway).IPv4DefaultGateway.NextHop
$gatewayTest = Test-Connection $gateway -Count 1 -Quiet
$internetTest = Test-Connection 8.8.8.8 -Count 1 -Quiet
try {
    Resolve-DnsName google.com -ErrorAction Stop | Out-Null
    $dnsTest = $true
}
catch {
    $dnsTest = $false
}

Write-Host "IPv4 Address: $ip"
Write-Host "Default Gateway: $gateway"
Write-Host "Gateway Connectivity: $gatewayTest"
Write-Host "Internet Connectivity: $internetTest"
Write-Host "DNS Resolution: $dnsTest"
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
if ($gatewayTest -ne $null) {
    Write-Host "[3] Gateway Connectivity : OK"
}
else {
    Write-Host "[3] Gateway Connectivity : FAILED"
}
if ($internetTest -ne $null) {
    Write-Host "[4] Internet Connectivity : OK"
}
else {
    Write-Host "[4] Internet Connectivity : FAILED"
}
if ($dnsTest -ne $null) {
    Write-Host "[5] DNS Resolution : OK"
}
else {
    Write-Host "[5] DNS Resolution : FAILED"
}
if ( $gatewayTest -and $internetTest -and $dnsTest) {
    Write-Host "Diagnosis: OK"
}
else {
    Write-Host "Diagnosis: FAILED"
}