
function Get-ComputerSite($ComputerName)
{
   $site = nltest /server:$ComputerName /dsgetsite 2>$null
   if($LASTEXITCODE -eq 0){ $site[0] }
}
 

# Empty array to put pc from selected site.
 $all_site_list = @()


# All pc from AD
 $all_pc = Get-ADComputer -Filter * 

 foreach ($comp in $all_pc) {
    $site = Get-ComputerSite $comp.Name
    $list = "" | select "CName", "CSite"
    $list.CName = $comp.Name
    $list.CSite = $site
    write-host $list
    $all_site_list += $list
    $list = $null
 }

