import-module ($Env:SMS_ADMIN_UI_PATH.Substring(0,$Env:SMS_ADMIN_UI_PATH.Length-5) + '\ConfigurationManager.psd1')
$PSD = Get-PSDrive -PSProvider CMSite
CD "$($PSD):"

$devs = Get-CMDevice

foreach ($i in $devs) {

    if (($i.ADSiteName -eq "clo") -or ($i.ADSiteName -eq "ur") -or ($i.ADSiteName -eq "sib") `
        -or ($i.ADSiteName -eq "ms") -or ($i.ADSiteName -eq "sh") -or ($i.ADSiteName -eq "hq") `
        -or ($i.ADSiteName -eq "chl") -or ($i.ADSiteName -eq "prm") -or ($i.ADSiteName -eq "msk") `
        -or ($i.ADSiteName -eq "klm") -or ($i.ADSiteName -eq "kln") -or ($i.ADSiteName -eq "krs") )  {
        if ($i.IsActive -eq "True") {
                Write-Host $i.Name "`t`t`tin " $i.ADSiteName "`t: Agent Already Installed!" -ForegroundColor Green
                sleep 5
        } else {
                Write-Host $i.Name "`t`t`tin " $i.ADSiteName "`t: agent not installed." -ForegroundColor Red
                #Install-CMClient -DeviceName $i.CName -ForceReinstall $true -AlwaysInstallClient $true -IncludeDomainController $true -SiteCode CCM
                Install-CMClient -DeviceName $i.Name -ForceReinstall $true -AlwaysInstallClient $true -SiteCode CCM
                sleep 5
                }
                
   }
}
 