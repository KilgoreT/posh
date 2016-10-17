# Порт 192.168.128.239 меняем на km7e1a49
if (Get-Printer | where PortName -like "*192.168.128.239*") {
Add-PrinterPort -Name ‘km7e1a49:’ -PrinterHostAddress ‘km7e1a49’  
Get-Printer | where PortName -like "*192.168.128.239*" | Set-Printer -PortName km7e1a49 
Get-PrinterPort | Where name -eq ‘192.168.128.239:’ | Remove-PrinterPort  
}  

# Порт 192.168.128.95 меняем на kmb5615f
if (Get-Printer | where PortName -like "*192.168.128.95*") {
Add-PrinterPort -Name ‘kmb5615f’ -PrinterHostAddress ‘kmb5615f’  
Get-Printer | where PortName -like "*192.168.128.95*" | Set-Printer -PortName kmb5615f 
Get-PrinterPort | Where name -eq ‘192.168.128.95’ | Remove-PrinterPort  
}

# Порт 192.168.128.142 меняем на lw14528922
if (Get-Printer | where PortName -like "*192.168.128.142*") {
Add-PrinterPort -Name ‘lw14528922’ -PrinterHostAddress ‘lw14528922’  
Get-Printer | where PortName -like "*192.168.128.142*" | Set-Printer -PortName lw14528922 
Get-PrinterPort | Where name -eq ‘192.168.128.142’ | Remove-PrinterPort  
}  

# Порт 192.168.128.38 меняем на LW15369951
if (Get-Printer | where PortName -like "*192.168.128.38*") {
Add-PrinterPort -Name ‘LW15369951’ -PrinterHostAddress ‘LW15369951’  
Get-Printer | where PortName -like "*192.168.128.38*" | Set-Printer -PortName LW15369951 
Get-PrinterPort | Where name -eq ‘192.168.128.38’ | Remove-PrinterPort  
}

# Порт 192.168.128.131 меняем на kmaf33c8
if (Get-Printer | where PortName -like "*192.168.128.131*") {
Add-PrinterPort -Name ‘kmaf33c8’ -PrinterHostAddress ‘kmaf33c8’  
Get-Printer | where PortName -like "*192.168.128.131*" | Set-Printer -PortName kmaf33c8 
Get-PrinterPort | Where name -eq ‘192.168.128.131’ | Remove-PrinterPort  
}

# Порт 192.168.128.15 меняем на KMAD0AC3
if (Get-Printer | where PortName -like "*192.168.128.15*") {
Add-PrinterPort -Name ‘KMAD0AC3’ -PrinterHostAddress ‘KMAD0AC3’  
Get-Printer | where PortName -like "*192.168.128.15*" | Set-Printer -PortName KMAD0AC3 
Get-PrinterPort | Where name -eq ‘192.168.128.15’ | Remove-PrinterPort  
}

