import-module ($Env:SMS_ADMIN_UI_PATH.Substring(0,$Env:SMS_ADMIN_UI_PATH.Length-5) + '\ConfigurationManager.psd1')
$PSD = Get-PSDrive -PSProvider CMSite
CD "$($PSD):"

$all = Get-Content C:\temp\all.txt

foreach ($dev_name in $all) {
    Write-Host "Adding $dev_name..." -ForegroundColor Green
    $dev = Get-CMDevice -Name $dev_name
    Write-Host "... detected id: " $dev.ResourceID
    Add-CMDeviceCollectionDirectMembershipRule -CollectionName "List upgraded to 10" -ResourceId $dev.ResourceID
    Start-Sleep -Seconds 3

}