# Сканирует в AD на наличие установленной роли у компьютеров домена, 
#         проверяет на них, сколько виртуалок создано, и сколько из них запущено.

Import-Module Hyper-V

$file = "C:\Users\apomazkin-adm\Desktop\script\HVStat.txt"
$stats = @()


$all = Get-ADObject -Filter 'ObjectClass -eq "serviceConnectionPoint" -and Name -eq "Microsoft Hyper-V"' | ForEach-Object {$_.DistinguishedName.Split(",")[1].replace("CN=","")}

foreach ($hpv in $all) {

    $is_online = $True
    $version = Get-ADComputer -Identity $hpv -Properties * | Select-Object OperatingSystem
    If ($version.OperatingSystem -match "2012") {

        if (Test-Connection $hpv -Count 1 -Quiet) {
            
            $AllVMs = Get-VM -ComputerName $hpv
            $RunVMs = Get-VM -ComputerName $hpv | where State -eq "Running"
            $AllVMsC = $AllVMs.Count
            $RunVMsC = $RunVMs.Count
            }
        else {
                $is_online = $false
                $AllVMsC = 0
                $RunVMsC = 0
                 }
        }
    elseif ($version.OperatingSystem -match "2008") {
            if (Test-Connection $hpv -Count 1 -Quiet) {
                $vms = Get-WmiObject -Class Msvm_ComputerSystem -Namespace "root\virtualization" -ComputerName $hpv  
                $AllVMs = $vms | where-object{$_.caption -ne "Hosting Computer System"}
                $RunVMs = $AllVMs | where-object{$_.enabledstate -match "2"}
                $AllVMsC = $AllVMs.Count
                $RunVMsC = $RunVMs.Count
         }
    else {
            $is_online = $false
         }
         
  
   } 

   $hvstats = "" | Select "host", "AllVmCount", "RunVmCount", "OSVersion", "IsOnline"
   $hvstats.host = $hpv
   $hvstats.AllVmCount = $AllVMsC
   $hvstats.RunVmCount = $RunVMsC
   $hvstats.OSVersion = $version.OperatingSystem
   $hvstats.ISOnline = $is_online
   $stats += $hvstats
   $hvstats = $null
}


$stats | Out-GridView