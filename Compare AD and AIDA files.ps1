$stats = @()

#$all = Get-Item -Path \\inventar\aida-report\*
$1date = (get-date -Date "00:00:00").AddDays(-1)
#$2date = (get-date -Date "00:00:00")
$2date = (get-date)
#$stats = Get-ChildItem -Path \\inventar\aida-report\* -Recurse -Include *.txt | where { ($_.LastWriteTime -lt $2date) -and ($_.LastWriteTime -gt $1date)}
$stats = Get-ChildItem -Path \\inventar\aida-report\* -Recurse -Include *.txt | where {$_.LastWriteTime -gt $1date}
$date = (Get-Date).AddDays(-30)
$ADdev = Get-ADComputer -Properties LastLogonDate -Filter {LastLogonDate -gt $date}

$st_name = @()

foreach ($i in $stats) {
    $st_name += $i.BaseName
}

$ad_name = @()

foreach ($i in $ADdev) {
    $ad_name += $i.Name
}


$div = Compare-Object -ReferenceObject $st_name -DifferenceObject $ad_name

Write-Host "Инвентаризировано: " $st_name.Count -ForegroundColor Green
Write-Host "Всего в AD: " $ad_name.Count -ForegroundColor Green
Write-Host "Не инвентаризировано: " $div.Count -ForegroundColor Red


