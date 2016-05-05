import-module ($Env:SMS_ADMIN_UI_PATH.Substring(0,$Env:SMS_ADMIN_UI_PATH.Length-5) + '\ConfigurationManager.psd1')
$PSD = Get-PSDrive -PSProvider CMSite
CD "$($PSD):"

$pcs = Import-Csv -Path C:\temp\allsites.csv

foreach ($i in $pcs) {

    if ($i.CSite -eq "msk") {
        $IsActive = Get-CMDevice -Name $i.CName
        if ($IsActive.IsActive -eq "True") {
                Write-Host $i.CName ": Agent Already Installed!"
        } else {
                Write-Host $i.CName ": Agent Not Installed."
                #Install-CMClient -DeviceName $i.CName -ForceReinstall $true -AlwaysInstallClient $true -IncludeDomainController $true -SiteCode CCM
                Install-CMClient -DeviceName $i.CName -ForceReinstall $true -AlwaysInstallClient $true -SiteCode CCM
                sleep 60
                }
                
   }
}
 