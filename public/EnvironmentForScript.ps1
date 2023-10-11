
function Set-EnvironmentForScript{
    [CmdletBinding()]
    param(
        [Parameter()][string]$ApiUrl='api.github.com',
        [Parameter()][string]$HostUrl='github.com',
        [Parameter()][string]$Owner='ps-developers-sandbox'
    )

    $script:GHDEVTRTCHSCPT_ENV = [PSCustomObject]@{
        ApiUrl = $ApiUrl
        HostUrl = $HostUrl
        Owner = $Owner
    }

    return $script:GHDEVTRTCHSCPT_ENV
} Export-ModuleMember -Function Set-EnvironmentForScript

function Get-EnvironmentForScript{
    [CmdletBinding()]
    param(
    )

    return $script:GHDEVTRTCHSCPT_ENV

} Export-ModuleMember -Function Get-EnvironmentForScript

function Get-OwnerFromEnvironment{
    [CmdletBinding()]
    param(
    )

    if(!(Test-EnvironmentForScript)){
        Set-EnvironmentForScript
    }

    $environment = Get-EnvironmentForScript

    $environment.Owner

} Export-ModuleMember -Function Get-OwnerFromEnvironment



function Test-EnvironmentForScript{
    [CmdletBinding()]
    param(
    )

    #check that $script:GHDEVTRTCHSCPT_ENV is not null
    if(! $script:GHDEVTRTCHSCPT_ENV){
        Write-Warning "GHDEVTRTCHSCPT_ENV is not set"
        return $false
    }

    #checkif $script:GHDEVTRTCHSCPT_ENV.ApiUrl is null or white spaces
    if([string]::IsNullOrWhiteSpace($script:GHDEVTRTCHSCPT_ENV.ApiUrl)){
        Write-Warning "GHDEVTRTCHSCPT_ENV.ApiUrl is not set"
        return $false
    }

    #checkif $script:GHDEVTRTCHSCPT_ENV.HostUrl is null or white spaces
    if([string]::IsNullOrWhiteSpace($script:GHDEVTRTCHSCPT_ENV.HostUrl)){
        Write-Warning "GHDEVTRTCHSCPT_ENV.HostUrl is not set"
        return $false
    }

    #checkif $script:GHDEVTRTCHSCPT_ENV.Owner is null or white spaces
    if([string]::IsNullOrWhiteSpace($script:GHDEVTRTCHSCPT_ENV.Owner)){
        Write-Warning "GHDEVTRTCHSCPT_ENV.Owner is not set"
        return $false
    }

    return $true
} Export-ModuleMember -Function Test-EnvironmentForScript


