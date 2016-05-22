function Get-ProcessPorts ($processId) {
    $netstats = Get-NetStat  
    return ($netstats | Where-Object ({$_["PID"] -eq $processId}) )
}

function Invoke-Netstat {
    netstat -ano;
}

function Get-NetStat {
    $netstatOutput = Invoke-Netstat
      
    $processPortInformation = New-Object System.Collections.ArrayList
    
    for($i=3; $i -lt $netstatOutput.count; $i++){
        $netstatLineArray = -Split $netstatOutput[$i]
        $processPortInformation.Add(@{
            "Protocol" = $netstatLineArray[0];
            "LocalAddr" = $netstatLineArray[1];
            "ForeignAddr" = $netstatLineArray[2];
            "State" = $netstatLineArray[3];
            "PID" = $netstatLineArray[4];
        }) | Out-Null;
    }
    #the comma forces this to always return as an array
    return ,$processPortInformation
}

