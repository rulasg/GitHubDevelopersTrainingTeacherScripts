
function Clear-EnvironmentForScript{
    [CmdletBinding()]
    param(
    )

    $script:GHDEVTRTCHSCPT_ENV = $null

} Export-ModuleMember -Function Clear-EnvironmentForScript

function Set-EnvironmentForScript{
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter()][string]$ApiUrl='api.github.com',
        [Parameter()][string]$HostUrl='github.com',
        [Parameter()][string]$Owner='ps-developers-sandbox'
    )

    $environment = [PSCustomObject]@{
        ApiUrl = $ApiUrl
        HostUrl = $HostUrl
        Owner = $Owner
    }

    if(Test-EnvironmentForScript -EnvironmentObject $environment){
        $ret = $environment
 
        if ($PSCmdlet.ShouldProcess('$script:GHDEVTRTCHSCPT_ENV', 'Update value')) {
            $script:GHDEVTRTCHSCPT_ENV = $environment
        } else {
            Write-Information "$ApiUrl, $HostUrl, $Owner"
        }

    } else {
        $ret = $script:GHDEVTRTCHSCPT_ENV
    }

    return $ret

} Export-ModuleMember -Function Set-EnvironmentForScript

function Get-EnvironmentForScript{
    [CmdletBinding()]
    param(
    )

    $environment = $(Test-EnvironmentForScript) ?  $script:GHDEVTRTCHSCPT_ENV : $(Set-EnvironmentForScript)

    return $environment

} Export-ModuleMember -Function Get-EnvironmentForScript

function Get-OwnerFromEnvironment{
    [CmdletBinding()]
    param(
    )

    $environment = Get-EnvironmentForScript

    $environment.Owner

} Export-ModuleMember -Function Get-OwnerFromEnvironment

function Test-EnvironmentForScript{
    [CmdletBinding()]
    param(
        [parameter()][PSCustomObject]$EnvironmentObject
    )

    $environmentObject = $EnvironmentObject ? $EnvironmentObject : $script:GHDEVTRTCHSCPT_ENV

    #check that $script:GHDEVTRTCHSCPT_ENV is not null
    if(! $environmentObject){
        Write-Warning "EnvironmentObject is Null"
        return $false
    }

    #checkif $EnvironmentObject.ApiUrl is null or white spaces
    if([string]::IsNullOrWhiteSpace($EnvironmentObject.ApiUrl)){
        Write-Warning "ApiUrl is not set"
        return $false
    }

    #checkif $EnvironmentObject.HostUrl is null or white spaces
    if([string]::IsNullOrWhiteSpace($EnvironmentObject.HostUrl)){
        Write-Warning "HostUrl is not set"
        return $false
    }

    #checkif $EnvironmentObject.Owner is null or white spaces
    if([string]::IsNullOrWhiteSpace($EnvironmentObject.Owner)){
        Write-Warning "Owner is not set"
        return $false
    }

    return $true
} Export-ModuleMember -Function Test-EnvironmentForScript

function Resolve-Owner{
    [CmdletBinding()]
    param(
        [Parameter()][string]$Owner
    )

    if([string]::IsNullOrWhiteSpace($Owner)){
        return Get-OwnerFromEnvironment
    }

    return $Owner
} Export-ModuleMember -Function Resolve-Owner
