#$computer = Get-ADComputer -Filter { OperatingSystem -NotLike '*server*' } -Property *
#$BitLockerObjects = Get-ADObject -Filter {objectclass -eq 'msFVE-RecoveryInformation'} -SearchBase [string]$computer.DistinguishedName -Properties 'msFVE-RecoveryPassword'
$BitLockerObjects = Get-ADObject -Filter {objectclass -eq 'msFVE-RecoveryInformation'} -Properties 'msFVE-RecoveryPassword'
$BitLockerObjects | ft DistinguishedName