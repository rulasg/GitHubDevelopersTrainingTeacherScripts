
function Set-EnvironmentForScripts{
    [CmdletBinding()]
    param(
        [Parameter()][string]$INSTANCE_URL='api.github.com',
        [Parameter()][string]$ROOT_URL='github.com',
        [Parameter()][string]$CLASS_ORG='ps-developers-sandbox'
    )

    $global:INSTANCE_URL = $INSTANCE_URL
    $global:ROOT_URL = $ROOT_URL
    $global:CLASS_ORG = $CLASS_ORG

    Get-EnvironmentForScripts
} Export-ModuleMember -Function Set-EnvironmentForScripts

function Get-EnvironmentForScripts{
    [CmdletBinding()]
    param(
    )

    [PSCustomObject]@{
        INSTANCE_URL = $global:INSTANCE_URL
        ROOT_URL = $global:ROOT_URL
        CLASS_ORG = $global:CLASS_ORG
    }
} Export-ModuleMember -Function Get-EnvironmentForScripts

function Get-EnvOwner{
    [CmdletBinding()]
    param(
    )

    if(!Test-EnvironmentForScripts){
        Set-EnvironmentForScripts
    }

    $environment = Get-EnvironmentForScripts

    $environment.CLASS_ORG
} Export-ModuleMember -Function Get-EnvOwner


function Test-EnvironmentForScripts{
    [CmdletBinding()]
    param(
    )

    $ret = $true

    #check if INSTANCE_URL is null or white spaces
    if([string]::IsNullOrWhiteSpace($global:INSTANCE_URL)){
        Write-Warning "INSTANCE_URL is not set"
        $ret = $false
    }
    

    #check if ROOT_URL is null or white spaces
    if([string]::IsNullOrWhiteSpace($global:ROOT_URL)){
        Write-Warning "ROOT_URL is not set"
        $ret = $false
    }

    #check if CLASS_ORG null or white spaces
    if([string]::IsNullOrWhiteSpace($global:CLASS_ORG)){
        Write-Warning "CLASS_ORG is not set"
        $ret = $false
    }

    return $ret

} Export-ModuleMember -Function Test-EnvironmentForScripts

