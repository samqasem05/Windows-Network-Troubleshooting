#Troubleshooting the internet for a user

#[GATHER ADAPATER INFO FIRST]

$gatheradpaterinfo = Get-NetAdapter -Name "Wi-Fi"

if($gatheradpaterinfo.Status -notlike "Up"){

    write-host "[Adapter is down, restarting adapter]"

    $gatheradpaterinfo | Restart-NetAdapter -ErrorAction SilentlyContinue

    Write-Host "[Adaper restarted]" -ForegroundColor Green

    } else {

    write-host "[Adapter is already up.]" -ForegroundColor Yellow

    }




#[GATHER NET I[ CONFIG SECOND]

$gatherinterfaceaddress = Get-NetIPConfiguration -InterfaceAlias "Wi-Fi" -ErrorAction SilentlyContinue | select-object ipv4address, dnsserver, ipv4defaultgateway

if($gatherinterfaceaddress.ipv4address.ipaddress -like "169.254.*"){

    write-host "[APIa Detected, Releasing and renewing ip address....]" -ForegroundColor Yellow

    ipconfig /release
    ipconfig /renew

    write-host "[ip address renewed]" -ForegroundColor Green

    } else {

    Write-Host "[No Apipa detected, flushing dnscache...]" -ForegroundColor Yellow

    Clear-DnsClientCache

    Write-Host "[Dns cache cleared]" -ForegroundColor Green

    }


#[TEST CONNECTION AFTER FIX]

$PING = Test-NetConnection

if($ping.pingsucceeded -eq $true){

    write-host "Ping Succeeded with a RTT of $($ping.PingReplyDetails.RoundtripTime)" -ForegroundColor Green

    } else { 

    write-host "ping failed"

    }

$checkdns = Resolve-DnsName google.com -ErrorAction SilentlyContinue

if($checkdns){

    write-host "Domain Name resolved..." -ForegroundColor Green

    }


    



