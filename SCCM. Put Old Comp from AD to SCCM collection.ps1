# Добавление компьютерных учеток из AD в специальную коллекцию SCCM "Unexisting in AD"
# чтобы добавить эту коллекцию в исключения и эти учетки не светились как работающие.

Import-Module ActiveDirectory
import-module ($Env:SMS_ADMIN_UI_PATH.Substring(0,$Env:SMS_ADMIN_UI_PATH.Length-5) + '\ConfigurationManager.psd1')
$PSD = Get-PSDrive -PSProvider CMSite
CD "$($PSD):"



$date = [DateTime]::Today.AddDays(-40)
$count =  1
#Get-ADComputer -Filter 'PasswordLastSet -le $date' -Properties PasswordLastSet  | Sort-Object PasswordLastSet | ft Name,PasswordLastSet -AutoSize
$oldedAD = Get-ADComputer -Filter 'PasswordLastSet -le $date' -Properties PasswordLastSet 



foreach ($i in $all) {
       if (Get-CMDevice -Name $i.Name) {
            $coll = Get-CMDeviceCollectionDirectMembershipRule -CollectionName "Unexisting in AD"
            if ($coll.RuleName -contains $i.Name) {
               # Write-Host $i.Name "already in collection" -ForegroundColor Red
            }
            else {
                Write-Host "Adding: " + $i.Name " to collection." -ForegroundColor Cyan
                Add-CMDeviceCollectionDirectMembershipRule -CollectionName "Unexisting in AD" -ResourceID (Get-CMDevice -Name $i.Name).ResourceID 
            }
       }
    }


$allNewAD = Get-ADComputer -Filter 'PasswordLastSet -ge $date' -Properties PasswordLastSet 

$CollMembers = Get-CMDeviceCollectionDirectMembershipRule -CollectionName "Unexisting in AD"

Write-Host "Number in collection: " $CollMembers.Count -ForegroundColor Green
Start-Sleep -Seconds 10



foreach ($i in $CollMembers) {
         if ($allNewAD.Name -contains $i.RuleName) {
           Write-Host $i.RuleName " was refreshed in AD:" -ForegroundColor Green
           $pc = Get-ADComputer -Identity $i.RuleName -Properties PasswordLastSet
           $now = [DateTime]::Today
           #Write-Host "in AD: " $(Get-ADComputer -Identity $i.RuleName -Properties PasswordLastSet).PasswordLastSet
           $t = $now -  $pc.PasswordLastSet
           Write-Host "Password was change in " $t.Days "Days and " $t.Hours " Hours ago."
           Start-Sleep -Seconds 5
           Write-Host "Remove " $i.RuleName " from collection." -ForegroundColor Green
           Remove-CMDeviceCollectionDirectMembershipRule -CollectionName "Unexisting in AD" -ResourceName $i.RuleName -Force
         }
}
