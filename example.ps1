Import-Module .\Get-NetStat\Get-NetStat.ps1

#this pipes the netstat output, then filters for outgoing connections on port 80, and extracts the ips using a regex

 Get-NetStat | Foreach-Object { Write-Output $_.ForeignAddr } | Where-Object { $_ -like "*:80" } | Select-String -Pattern $ipregex
 -AllMatches | % { $_.Matches} | % { $_.Value }
 
 #resolves dns
  Get-NetStat | Foreach-Object { Write-Output $_.ForeignAddr } | Where-Object { $_ -like "*:80" } | Select-String -Pattern $ipregex
 -AllMatches | % { $_.Matches} | % { $_.Value } | % { Write-Output "reverse lookup for $_"; Resolve-DnsName $_ }
 
 #get a count of process connecting out on a port
  $m = Get-NetStat | Foreach-Object { Write-Output $_.ForeignAddr } | Where-Object { $_ -like "*:9354" } | measure
  
  #run a remote command
  Invoke-Command -ComputerName $pcToCheck -ScriptBlock {}
  
  #ssh onto a box type thing
  Enter-PSSession -ComputerName COMPUTER -Credential USER