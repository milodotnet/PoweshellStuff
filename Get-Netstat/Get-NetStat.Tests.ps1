$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "Get-Netstat" {
    Mock Invoke-Netstat {  
        return "Active Connections",  
          "", 
          "Proto  Local Address          Foreign Address        State           PID", 
          "TCP    0.0.0.0:80             0.0.0.0:0              LISTENING       4",
          "TCP    0.0.0.0:80             0.0.0.0:0              LISTENING       5"
    }

    It "Should return process port information" {
        
        $netStatOut = Get-NetStat
        $netStatOut[0]["Protocol"] | Should Be 'TCP'
        $netStatOut[0]["LocalAddr"] | Should Be '0.0.0.0:80'
        $netStatOut[0]["ForeignAddr"] | Should Be '0.0.0.0:0'
        $netStatOut[0]["State"] | Should Be 'LISTENING'
        $netStatOut[0]["PID"] | Should Be '4'
        
        $netStatOut[1]["Protocol"] | Should Be 'TCP'
        $netStatOut[1]["LocalAddr"] | Should Be '0.0.0.0:80'
        $netStatOut[1]["ForeignAddr"] | Should Be '0.0.0.0:0'
        $netStatOut[1]["State"] | Should Be 'LISTENING'
        $netStatOut[1]["PID"] | Should Be '5'        
    }
}

Describe "Get-Netstat" {
    Mock Invoke-Netstat {  
        return "Active Connections",  
          "", 
          "Proto  Local Address          Foreign Address        State           PID", 
          "TCP    0.0.0.0:80             0.0.0.0:0              LISTENING       4"          
    }

    It "Should return process port when only one entty" {
        
        $netStatOut = Get-NetStat
        $netStatOut[0]["Protocol"] | Should Be 'TCP'
        $netStatOut[0]["LocalAddr"] | Should Be '0.0.0.0:80'
        $netStatOut[0]["ForeignAddr"] | Should Be '0.0.0.0:0'
        $netStatOut[0]["State"] | Should Be 'LISTENING'
        $netStatOut[0]["PID"] | Should Be '4'
        
    }
}