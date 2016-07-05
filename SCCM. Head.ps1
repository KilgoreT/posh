import-module ($Env:SMS_ADMIN_UI_PATH.Substring(0,$Env:SMS_ADMIN_UI_PATH.Length-5) + '\ConfigurationManager.psd1')
$PSD = Get-PSDrive -PSProvider CMSite
CD "$($PSD):"

$Packages = Get-CMDeploymentPackage -DistributionPointName sccm.kontur
$command = "Publish-CMPrestageContent "

Switch ($Packages.ObjectTypeID) {            
        2  { $command += "-PackageID $($Packages.PackageID) " }
        14 { $command += "-OperatingSystemInstallerId $($Packages.PackageID) "}           
        31 { $command += "-ApplicationName '$($Packages.Name)' "} 
    }