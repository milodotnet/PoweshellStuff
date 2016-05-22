function TestOutgoingConnections ($port) {
    $m = Get-NetStat | Foreach-Object { Write-Output $_.ForeignAddr } | Where-Object { $_ -like "*:$port" } | measure
    return $m.Count
}
