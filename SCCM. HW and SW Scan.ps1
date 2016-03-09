import-module ($Env:SMS_ADMIN_UI_PATH.Substring(0,$Env:SMS_ADMIN_UI_PATH.Length-5) + '\ConfigurationManager.psd1')
$PSD = Get-PSDrive -PSProvider CMSite
CD "$($PSD):"

$ErrCount = 0

$action = "hw"

switch ($action) 
    { 
        hw { $id = "{00000000-0000-0000-0000-000000000001}"
             #$CollName = "Hardware Scan missing for 30 days" } 
              $CollName = "Hardware Scan missing for half-year" } 
        sw { $id = "{00000000-0000-0000-0000-000000000002}"
             $CollName = "Software Scan missing for 30 days" } 
        default { $id = "{00000000-0000-0000-0000-000000000001}"
                  $CollName = "Without Scan Date"}
    }


$date = [DateTime]::Today.AddDays(-1)
#$CollName = "Hardware Scan missing for half-year"
$dev = Get-CMDevice -CollectionName $CollName | where {$_.LastActiveTime -ge $date}
 




foreach ($i in $dev) {

$i.Name + " : "
Invoke-WmiMethod -ComputerName $i.Name -Namespace root\ccm -Class sms_client -Name TriggerSchedule $id -ErrorVariable ErVar
if ($ErVar) {
    $ErrCount = $ErrCount + 1
}
"-------------"
}

$dev.Count
$ErrCount

$CollName