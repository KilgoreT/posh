#Get-VM -ComputerName ulhost8 | ft ComputerName, Name, ProcessorCount, MemoryAssigned, State -AutoSize

$AllVms = @()
$Hosts = "Ulhost8", "Ulhost9", "Ulhost10", "Ulhost11", "Ulhost12", "Ulhost13", "Ulhost14", "suf2", "ulhost17", "nci-sql1", "nci-sql2"
foreach ($h in $Hosts) {
    $VMs = Get-VM -ComputerName $h
    foreach ($vm in $VMs) {
     
        "host: " + $h + "; VM: " + $vm.Name 

        $VmInfo = "" | Select "HostName", "VmName", "ProcessorCount", "MemoryAssigned", "HDD", "State"
        $VmInfo.HostName = $h
        $VmInfo.VmName = $vm.Name
        $VmInfo.ProcessorCount = Get-VM -Name $vm.Name -ComputerName $h | Select-Object ProcessorCount
        $VmInfo.MemoryAssigned = Get-VM -Name $vm.Name -ComputerName $h | Select-Object DynamicMemoryEnabled, MemoryAssigned, MemoryMinimum, MemoryMaximum
        $VmInfo.HDD = Get-VM $vm.Name -ComputerName $h | Select-Object vmid | Get-VHD -ComputerName $h | Select-Object Size
        $VmInfo.State = Get-VM -Name $vm.Name -ComputerName $h | Select-Object State

        $AllVms += $VmInfo
        $VmInfo = $null
    }
}

$AllVms | Out-GridView

#$VMs = Get-VM -ComputerName ulhost9

#foreach ($i in $VMs) {
#    $vmdisksize = Get-VM $i.Name -ComputerName ulhost9 | Select-Object vmid | Get-VHD -ComputerName ulhost9 | Select-Object Size
#    #Get-VM -Name $i.Name -ComputerName ulhost9 | ft ComputerName, Name, ProcessorCount, MemoryAssigned, $vmdisksize, State -AutoSize
#    Get-VM -Name $i.Name -ComputerName ulhost9 | Select-Object ComputerName, Name, ProcessorCount, MemoryAssigned, $vmdisksize, State
    
#}