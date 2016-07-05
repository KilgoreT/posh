import-module ($Env:SMS_ADMIN_UI_PATH.Substring(0,$Env:SMS_ADMIN_UI_PATH.Length-5) + '\ConfigurationManager.psd1')
$PSD = Get-PSDrive -PSProvider CMSite
CD "$($PSD):"

# Function to get adsite of same pc.

function Get-ComputerSite($ComputerName)
{
   $site = nltest /server:$ComputerName /dsgetsite 2>$null
   if($LASTEXITCODE -eq 0){ $site[0] }
}
 
# sleep 1800

# Empty array to put pc from selected site.
 $all_sites = @()
# All pc from AD
 $all = Get-ADComputer -Filter * 


 foreach ($comp in $all) {
    $site = Get-ComputerSite $comp.Name
   # Write-Host $site ": " $comp.Name
    if (
        $comp.Name -ne "SCCM2012"
        <#($site -eq "clo") -or ($site -eq "ur") -or ($site -eq "sib") `
        -or ($site -eq "ms") -or ($site -eq "sh") -or ($site -eq "hq") `
        -or ($site -eq "chl") -or ($site -eq "prm") -or ($site -eq "msk") `
        -or ($site -eq "klm") -or ($site -eq "kln") -or ($site -eq "krs") -or ($site -eq "nv") -or ($site -eq "ra")
        #>

        ) `
    {
        #Write-Host $site ": " $comp.Name
        $all_sites += $comp.Name
        $IsActive = Get-CMDevice -Name $comp.Name
        if ($IsActive.IsActive -eq "True") {
            Write-Host $site ": " $comp.Name "`t`t--- agent already installed!" -ForegroundColor Green
        } else {
            Write-Host $site ": " $comp.Name "`t`t--- agent not installed." -ForegroundColor Red
           # Get-CMDevice -Name $comp.Name | 
           Install-CMClient -DeviceName $comp.Name -ForceReinstall $true -AlwaysInstallClient $true -SiteCode CCM
                }
    }
    else {
        Write-Host "SCCM2012 is not include." -ForegroundColor Cyan
    }
 }
 
 
 