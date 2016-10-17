import-module ($Env:SMS_ADMIN_UI_PATH.Substring(0,$Env:SMS_ADMIN_UI_PATH.Length-5) + '\ConfigurationManager.psd1')
$PSD = Get-PSDrive -PSProvider CMSite
CD "$($PSD):"

$real = @()
$unreal = @()

$all = Get-Content C:\tmp\aida.txt

foreach ($i in $all) {
    $info = Get-CMDevice -Name $i
    if ($info.IsVirtualMachine -eq $false) {
        Write-Host $i " is real."-ForegroundColor Green
        $real += $info.Name

    } else {
        Write-Host $i " is virtual." -ForegroundColor Red
        $unreal += $info.Name
    }
}

