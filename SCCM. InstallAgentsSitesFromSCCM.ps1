import-module ($Env:SMS_ADMIN_UI_PATH.Substring(0,$Env:SMS_ADMIN_UI_PATH.Length-5) + '\ConfigurationManager.psd1')
$PSD = Get-PSDrive -PSProvider CMSite
CD "$($PSD):"

$devs = Get-CMDevice

foreach ($i in $devs) {

    if ($i.ADSiteName -eq "msk") {
        if ($i.IsActive -eq "True") {
                Write-Host $i.Name ": Agent Already Installed!"
        } else {
                Write-Host $i.Name ": Agent Not Installed."
                #Install-CMClient -DeviceName $i.CName -ForceReinstall $true -AlwaysInstallClient $true -IncludeDomainController $true -SiteCode CCM
                #Install-CMClient -DeviceName $i.Name -ForceReinstall $true -AlwaysInstallClient $true -SiteCode CCM
                sleep 5
                }
                
   }
}
 