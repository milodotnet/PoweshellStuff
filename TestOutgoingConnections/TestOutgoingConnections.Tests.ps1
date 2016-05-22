$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "TestOutgoingConnections" {
    It "There should be no outgoing connections on port 80" {
        TestOutgoingConnections 9354 | Should Be 0
    }
}
