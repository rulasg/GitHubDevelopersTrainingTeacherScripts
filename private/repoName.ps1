function Get-ActivityRepoName{
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)][ValidateSet("conflict-practice", "github-games")][string]$ActivityRepo,
        [Parameter(Mandatory, Position=0)][string]$User,
        [Parameter()][string]$Owner
    )

    # Check if $owner is null or white spaces
    if([string]::IsNullOrWhiteSpace($Owner)){
        $Owner = Get-OwnerFromEnvironment
    }

    $Owner = $Owner.Trim()

    $repoName = "{0}/{1}-{2}" -f $Owner,$ActivityRepo,$User

    return $repoName
}

function Get-ClassRepoName{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string]$RepoName,
        [Parameter()][string]$Owner
    )

    # Check if $owner is null or white spaces
    if([string]::IsNullOrWhiteSpace($Owner)){
        $Owner = Get-OwnerFromEnvironment
    }

    $Owner = $Owner.Trim()

    $ret = "{0}/{1}" -f $Owner,$RepoName

    return $ret
}