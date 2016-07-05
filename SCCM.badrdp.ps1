﻿#param($out)

$regKey = "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp"
$regName = "Security"

$regValue = Get-ItemProperty $regKey $regName


[byte[]] $badval = 0x01,0x00,0x14,0x80,0x64,0x00,0x00,0x00,0x70,0x00,0x00,0x00,0x14,0x00,0x00,0x00,0x30,0x00,0x00,0x00,0x02, `
  0x00,0x1c,0x00,0x01,0x00,0x00,0x00,0x02,0x80,0x14,0x00,0x21,0x01,0x00,0x00,0x01,0x01,0x00,0x00,0x00,0x00,0x00,0x01,0x00,0x00, `
  0x00,0x00,0x02,0x00,0x34,0x00,0x01,0x00,0x00,0x00,0x00,0x00,0x24,0x00,0xff,0x03,0x0f,0x00,0x01,0x05,0x00,0x00,0x00,0x00,0x00, `
  0x05,0x15,0x00,0x00,0x00,0x11,0x81,0xf4,0x5b,0xaf,0x2d,0x07,0x49,0x9a,0xf8,0xa9,0x16,0xef,0x03,0x00,0x00,0x75,0x00,0x70,0x00, `
  0x5d,0x00,0x00,0x00,0x01,0x01,0x00,0x00,0x00,0x00,0x00,0x05,0x12,0x00,0x00,0x00,0x01,0x01,0x00,0x00,0x00,0x00,0x00,0x05,0x12, `
  0x00,0x00,0x00

[byte[]] $badval = 0x01,0x00,0x04,0x80,0xc8,0x00,0x00,0x00,0xd4,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x14,0x00,0x00,0x00,0x02, `
  0x00,0xb4,0x00,0x07,0x00,0x00,0x00,0x00,0x00,0x14,0x00,0x01,0x00,0x00,0x00,0x01,0x01,0x00,0x00,0x00,0x00,0x00,0x05,0x04,0x00, `
  0x00,0x00,0x00,0x00,0x14,0x00,0xbf,0x03,0x0f,0x00,0x01,0x01,0x00,0x00,0x00,0x00,0x00,0x05,0x12,0x00,0x00,0x00,0x00,0x00,0x14, `
  0x00,0x89,0x00,0x0f,0x00,0x01,0x01,0x00,0x00,0x00,0x00,0x00,0x05,0x13,0x00,0x00,0x00,0x00,0x00,0x14,0x00,0x81,0x00,0x00,0x00, `
  0x01,0x01,0x00,0x00,0x00,0x00,0x00,0x05,0x14,0x00,0x00,0x00,0x00,0x00,0x18,0x00,0xbf,0x03,0x0f,0x00,0x01,0x02,0x00,0x00,0x00, `
  0x00,0x00,0x05,0x20,0x00,0x00,0x00,0x20,0x02,0x00,0x00,0x00,0x00,0x18,0x00,0x21,0x01,0x00,0x00,0x01,0x02,0x00,0x00,0x00,0x00, `
  0x00,0x05,0x20,0x00,0x00,0x00,0x2b,0x02,0x00,0x00,0x00,0x00,0x24,0x00,0xff,0x03,0x0f,0x00,0x01,0x05,0x00,0x00,0x00,0x00,0x00, `
  0x05,0x15,0x00,0x00,0x00,0x88,0x40,0x06,0xe4,0xcf,0x67,0x22,0x28,0x37,0xbc,0x49,0x86,0xed,0x03,0x00,0x00,0x00,0x00,0x00,0x00, `
  0x00,0x00,0x00,0x00,0x01,0x01,0x00,0x00,0x00,0x00,0x00,0x05,0x12,0x00,0x00,0x00,0x01,0x01,0x00,0x00,0x00,0x00,0x00,0x05,0x12, `
  0x00,0x00,0x00


If ($regValue.$regName -eq $badval) {

Write-Output “NonCompliant”

}

else {

Write-Output “Compliant”

}