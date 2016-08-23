#$all = Get-ADCompute

$allrst = get-adcomputer -properties Name -Filter *|  where {$_.name -match "^RST"}

#Set-GPPermissions -Name "AIDA" -PermissionLevel GpoApply -TargetName "$($allrst[0].Name)" -TargetType Computer -Server ulboss


foreach ($i in $allrst) {
    $i.Name
    Set-GPPermissions -Name "AIDA" -PermissionLevel GpoApply -TargetName "$($i.Name)" -TargetType Computer -Server ulboss
}