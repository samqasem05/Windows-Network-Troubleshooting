#COMPUTER INFO

$computername = $env:COMPUTERNAME | select-object 

$currentusername = $env:USERNAME

$currentdatetime = get-date

#NETWORK INFO

$adapter = Get-NetAdapter -Name "Wi-Fi"

$ipv4info = Get-NetIPAddress -AddressFamily IPv4  -InterfaceAlias "Wi-Fi"

$gateway = Get-NetIPConfiguration -InterfaceAlias "Wi-FI"| select-object ipv4defaultgateway

$checkdhcp = Get-Service -Name Dhcp | select-object status


$layout = if($checkdhcp.status -like "Stopped"){

    write-host " dhcp service is stopped" -ForegroundColor Red

    Start-Service -Name Dhcp

    Write-Host "DHCP service started"

    } else { 

        write-host "DHCP service is running" -ForegroundColor Green

    }

    $attemptdnsresolve = Resolve-DnsName FS01 -ErrorAction SilentlyContinue

    if($attemptdnsresolve.Section -like "Answer"){

        write-host "Can resolve" -ForegroundColor Green

    } else { 

        write-host "Cant resolve dns name to FS01" -ForegroundColor Red

        }


    $attempttoping = Test-Connection -ComputerName msi "10.20.30.1", "10.20.10.10", "10.20.50.10" -count 1 -erroraction silentlycontinue


    if($attempttoping){

        write-host "Test established" -ForegroundColor Green

        } else { 

             write-host "Test connection on [10.20.30.1], [10.20.10.10], [10.20.50.10] Failed" -ForegroundColor red

    }


     $testtcp = Test-NetConnection FS01 -Port 445 -ErrorAction SilentlyContinue

     if($testtcp.tcptestsucceeded -eq "True"){

         write-host "FS01 port 445 tcp test succeeded" -ForegroundColor Green

          } else { 

          write-host " [TCP] Test failed for FS01 on port 445" -ForegroundColor Red

    }

       $testFS01publicpath = test-path "\\FS01\Public" -ErrorAction SilentlyContinue

      if($testFS01publicpath -eq "True"){

           write-host "FS01 path is reachable via testing path" -ForegroundColor Green

           } else {

           write-host "FS01 is not reachable via testing path" -ForegroundColor Red

    }


     [PSCustomObject]@{

            COMPUTERNAME = $computername

            CURRENTUSERNAME = $currentusername

            DATETIME = $currentdatetime

            ADAPTERSTATUS = $adapter.Name

            IPV4ADDRESS = $ipv4info

            GATEWAY = $gateway.IPv4DefaultGateway

            DHCPSTATUS = $checkdhcp.Status

            }

$LAYOUT















