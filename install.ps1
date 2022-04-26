New-Module -name Installer -scriptblock {
    function install() {
        param (
            [Parameter(Mandatory = $true)] $user,
            [Parameter(Mandatory = $true)] $repo,
            [string]$branch = "master",
            [bool]$remove = $false
        )

        $zipFile = "$repo.zip"
        $project = "$repo-$branch"
        $reposUrl = "https://api.github.com/repos/$user/$repo"
        $archiveUrl = "https://github.com/$user/$repo/archive/$branch.zip"
        $statusCode = Invoke-WebRequest $reposUrl | Select-Object -Expand StatusCode

        if ($statusCode -eq 200) {
            Invoke-WebRequest $archiveUrl -OutFile $zipFile
            Expand-Archive -Path $zipFile -DestinationPath . -Force
            Set-Location $project
            .\setup.bat
            Set-Location ..
            Remove-Item $zipFile, $project
        }
        else {
            Write-Error "$user/$repo repository not found"
        }
    }
    
    Export-ModuleMember -function "install"
}
