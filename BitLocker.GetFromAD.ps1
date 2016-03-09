# Get BitLocker information from AD,
#          such as: count bitlockered desktops, password recovery etc.



$BitLockerObjects = Get-ADObject -Filter {objectclass -eq 'msFVE-RecoveryInformation'} -Properties 'msFVE-RecoveryPassword'
$BitLockerObjects | ft DistinguishedName