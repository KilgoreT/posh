$stats = @()

#$all = Get-Item -Path \\inventar\aida-report\*
$1date = (get-date -Date "00:00:00").AddDays(-1)
#$2date = (get-date -Date "00:00:00")
$2date = (get-date)
#$stats = Get-ChildItem -Path \\inventar\aida-report\* -Recurse -Include *.txt | where { ($_.LastWriteTime -lt $2date) -and ($_.LastWriteTime -gt $1date)}
$stats = Get-ChildItem -Path \\inventar\aida-report\* -Recurse -Include *.txt | where {$_.LastWriteTime -gt $1date}
$date = (Get-Date).AddDays(-30)
#$ADdev = Get-ADComputer -Properties LastLogonDate -Filter {LastLogonDate -gt $date}
$ADdev = Get-ADComputer -Properties LastLogonDate -Filter {(LastLogonDate -gt $date) -and (OperatingSystem -NotLike "*server*")}

$st_name = @()

foreach ($i in $stats) {
    $st_name += $i.BaseName
}

$ad_name = @()

foreach ($i in $ADdev) {
    $ad_name += $i.Name
}

$non_stat = @()
$non_exist = @()
$non_resolve = @()
$non_ping = @()
$resolve = @()

$div = Compare-Object -ReferenceObject $st_name -DifferenceObject $ad_name


foreach ($i in $div) {
    if ($i.SideIndicator -eq "=>") {
        $non_stat += $i.InputObject
    }
    if ($i.SideIndicator -eq "<=") {
        $non_exist += $i.InputObject
    }
}

foreach ($i in $non_stat) {
    if (Resolve-DnsName -QuickTimeout -Name $i -ErrorAction SilentlyContinue) {
        if (Test-Connection -Count 1 -Quiet $i ) { 
            Write-Host $i "is Online" -ForegroundColor Green
            $resolve += $i
            } 
            else { 
                Write-Host $i "is Offline" -ForegroundColor Cyan
                $non_ping += $i
                    }
    } else {
        Write-Host $i "is not resolve." -ForegroundColor DarkMagenta
        $non_resolve += $i
    }
}

Write-Host "Инвентаризировано  : " $st_name.Count -ForegroundColor Green
Write-Host "Всего в AD         : " $ad_name.Count -ForegroundColor Green
#Write-Host "Разница в          : " $div.Count -ForegroundColor Magenta
#Write-Host "Устарело           : " $non_exist.Count -ForegroundColor Cyan
Write-Host "Неинвентаризировано: " $non_stat.Count -ForegroundColor Red

del C:\tmp\aida_host.txt
Write-Output $non_stat >> C:\tmp\aida_host.txt

del C:\tmp\aida_non_resolve.txt
Write-Output $non_resolve >> C:\tmp\aida_non_resolve.txt

del C:\tmp\aida_resolve_online.txt
Write-Output $resolve >> C:\tmp\aida_resolve_online.txt

del C:\tmp\aida_non_ping.txt
Write-Output $non_ping >> C:\tmp\aida_non_ping.txt

del C:\tmp\aida_old.txt
Write-Output $non_exist >> C:\tmp\aida_old.txt

#C:\tmp>PsExec.exe @C:\tmp\aida.txt -d -n 20 -h -u kontur\backupexec -p KxrRQ#NFLz7 \\inventar\AIDA\aida64.exe /SILENT /R \\inventar\aida-report\$HOSTNAME\$HOSTNAME.txt /TEXT /LANGRU /CUSTOM \\inventar\AIDA\aida64.rpf

