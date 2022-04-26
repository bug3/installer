New-Module -name Installer -scriptblock {
    function install() {
        param (
            [Parameter(Mandatory = $true)] $user,
            [Parameter(Mandatory = $true)] $repo,
            [string]$branch = "master",
            [bool]$remove = $false
        )
    }
    
    Export-ModuleMember -function "install"
}
