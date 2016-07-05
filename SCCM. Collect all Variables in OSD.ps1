New-Item -Path "HKLM:\Software\SCCMKontur\Variables" -Force
$MS_ConfigMgr_Env = New-Object -ComObject Microsoft.SMS.TSEnvironment
foreach ($MS_ConfigMgr_Var in $MS_ConfigMgr_Env.GetVariables())
{
  New-Itemproperty -Path "HKLM:\Software\David\Variables" -Name "$($MS_ConfigMgr_Var)" -Value "$($MS_ConfigMgr_Env.Value($MS_ConfigMgr_Var))" -Force
}