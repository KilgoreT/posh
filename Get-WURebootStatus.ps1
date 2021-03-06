Function Get-WURebootStatus
{
    <#
	.SYNOPSIS
	    Show Windows Update Reboot status.

	.DESCRIPTION
	    Use Get-WURebootStatus to check if reboot is needed.
		
	.PARAMETER Silent
	    Get only status True/False without any more comments on screen. 
	
	.EXAMPLE
        Check whether restart is necessary. If yes, ask to do this or don't.
		
		PS C:\> Get-WURebootStatus
		Reboot is required. Do it now ? [Y/N]: Y
		
	.EXAMPLE
		Silent check whether restart is necessary. It return only status True or False without restart machine.
	
        PS C:\> Get-WURebootStatus -Silent
		True
		
	
	#>    

	[CmdletBinding(
    	SupportsShouldProcess=$True,
        ConfirmImpact="Low"
    )]
    Param
	(
		[Alias("StatusOnly")]
		[Switch]$Silent,
		[String[]]$ComputerName = "localhost",
		[Switch]$AutoReboot
	)
	
	Begin
	{
		$User = [Security.Principal.WindowsIdentity]::GetCurrent()
		$Role = (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)

		if(!$Role)
		{
			Write-Warning "To perform some operations you must run an elevated Windows PowerShell console."	
		} #End If !$Role
	}
	
	Process
	{
        ForEach($Computer in $ComputerName)
		{
			If ($pscmdlet.ShouldProcess($Computer,"Check that Windows update needs to restart system to install next updates")) 
			{				
				if($Env:COMPUTERNAME,"localhost","." -contains $Computer)
				{
				    Write-Verbose "$($Computer): Using WUAPI"
					$objSystemInfo= New-Object -ComObject "Microsoft.Update.SystemInfo"
					$RebootRequired = $objSystemInfo.RebootRequired
				} #End if $Computer -eq $Env:COMPUTERNAME
				else
				{
					Write-Verbose "$($Computer): Using Registry"
					$RegistryKey = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]"LocalMachine",$Computer) 
					$RegistrySubKey = $RegistryKey.OpenSubKey("SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\") 
					$RegistrySubKeyNames = $RegistrySubKey.GetSubKeyNames() 
					$RebootRequired = $RegistrySubKeyNames -contains "RebootRequired" 

				} #End else $Computer -eq $Env:COMPUTERNAME
				
				Switch($RebootRequired)
				{
					$true	{
						
							Return $true
						
					} #End Switch $true
						
					$false	{ 
						
							Return $false
						
					} #End Switch $false
				} #End Switch $objSystemInfo.RebootRequired
				
			} #End If $pscmdlet.ShouldProcess($Env:COMPUTERNAME,"Check that Windows update needs to restart system to install next updates")
		} #End ForEach $Computer in $ComputerName
	} #End Process
	
	End{}				
} #In The End :)

Get-WURebootStatus