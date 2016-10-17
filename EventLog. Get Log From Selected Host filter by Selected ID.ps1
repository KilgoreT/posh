$all = @()

#$date = (get-date -Date "00:00:00").AddDays(-1)
$date = (get-date).AddMinutes(-3)
$now = (get-date)

$dcs = @("ulboss", "ulbackup", "shrboss", "shrbackup")

foreach ($dc in $dcs) {
    Write-Host $dc -ForegroundColor Green
    $all += Get-EventLog -ComputerName $dc -LogName Security -Newest 1000 | ?{($_.eventid -ge "6272") -and ($_.eventid -le "6280")} 
    #| select MachineName,Time,EventID,EntryType,Message


}

if ($all) { 
        $all | export-csv C:\tmp\logs\logs.csv -notypeinformation
    }