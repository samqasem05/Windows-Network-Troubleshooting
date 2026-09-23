$dhcp = Get-Service -name Dhcp

if($dhcp.name -like "*Dhcp*"){


    $status = $dhcp.Status -eq "Running"
    
    Write-Host "Dhcp is present" -ForegroundColor green

    $layout = [PSCustomObject]@{

              Service = $dhcp.Name
              IsServiceActive = $status

              }
            }

    $layout | convertto-json