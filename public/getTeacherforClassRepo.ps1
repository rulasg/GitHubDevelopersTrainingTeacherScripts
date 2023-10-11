
function Get-ClassRepoName{
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)][ValidateSet("conflict-practice", "github-games")][string]$ClassRepo,
        [Parameter(Mandatory, Position=0)][string]$User,
        [Parameter()][string]$Owner

    )

    # Check if $owner is null or white spaces
    if([string]::IsNullOrWhiteSpace($Owner)){
        $Owner = $(Get-OwnerFromEnvironment)
    }

    $repoName = "{0}/{1}-{2}" -f $Owner,$ClassRepo,$User

    return $repoName
}

function Get-TeacherOfConflictPracticeRepo{
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory, Position=0, ValueFromPipeline, ValueFromPipelineByPropertyName)] [string]$User,
        [Parameter()][string]$Owner
    )

    process{

        $repo = Get-ClassRepoName -User $User -Owner:$Owner -ClassRepo 'conflict-practice'

        $command = 'gh pr view 1 -R {0} --json author' -f $repo

        $result = Invoke-GhExpression $command -Whatif:$WhatIfPreference

        return $result
    }
} Export-ModuleMember -Function Get-TeacherOfConflictPracticeRepo

function Get-TeacherOfGithubGameRepo{
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory, Position=0, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$User,
        [Parameter()][string]$Owner
    )

    process{

        $repo = Get-ClassRepoName -user $User -Owner $Owner -ClassRepo 'github-games'

        $command = 'gh issue view 1 -R {0} --json author' -f $repo

        $result = Invoke-GhExpression $command -Whatif:$WhatIfPreference

        return $result
    }

} Export-ModuleMember -Function Get-TeacherOfGithubGameRepo
