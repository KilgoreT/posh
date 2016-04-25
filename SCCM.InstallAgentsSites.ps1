function Get-ComputerSite($ComputerName)
{
   $site = nltest /server:$ComputerName /dsgetsite 2>$null
   if($LASTEXITCODE -eq 0){ $site[0] }
}
 
 $all_sites = @()
 $all = Get-ADComputer -Filter * 

 foreach ($comp in $all) {
    $site = Get-ComputerSite $comp.Name
   # Write-Host $site ": " $comp.Name
    if ($site -eq "sh") {
        Write-Host $site ": " $comp.Name
        $all_sites += $comp.Name
    }
 }
 
 
 
 Get-ComputerSite k1109012
