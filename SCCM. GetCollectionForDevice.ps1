import-module ($Env:SMS_ADMIN_UI_PATH.Substring(0,$Env:SMS_ADMIN_UI_PATH.Length-5) + '\ConfigurationManager.psd1')
$PSD = Get-PSDrive -PSProvider CMSite
CD "$($PSD):"


$ResID = (Get-CMDevice -Name "k1109012").ResourceID
$Collections = (Get-WmiObject -Class sms_fullcollectionmembership -Namespace root\sms\site_CCM -Filter "ResourceID = '$($ResID)'").CollectionID
    foreach ($Collection in $Collections)
    {
      Get-CMDeviceCollection -CollectionId $Collection | select Name, CollectionID
    }