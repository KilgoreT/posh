# Function to get adsite of same pc.

function Get-ComputerSite($ComputerName)
{
   $site = nltest /server:$ComputerName /dsgetsite 2>$null
   if($LASTEXITCODE -eq 0){ $site[0] }
}
 

# Empty array to put pc from selected site.
 $all_sites = @()
# All pc from AD
 $all = Get-ADComputer -Filter * 


 foreach ($comp in $all) {
    $site = Get-ComputerSite $comp.Name
   # Write-Host $site ": " $comp.Name
    if ($site -eq "sh") {
        Write-Host $site ": " $comp.Name
        $all_sites += $comp.Name
        $IsActive = Get-CMDevice -Name $comp.Name
        if ($IsActive.IsActive -eq "True") {
            Write-Host "Agent Already Installed!"
        } else {Write-Host "Agent Not Installed."}
    }
 }
 
 
 
 Get-ComputerSite k1109012
