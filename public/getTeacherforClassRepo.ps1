function Get-TeacherOfClassRepo{
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)]
        [ValidateSet("conflict-practice", "github-games")]
        [string]$ClassRepo,
        [Parameter(Mandatory, Position=0, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$User
    )

    process{

        $environment = Get-EnvironmentForScripts

        $RepoName = "$CLASS_ORG/$ClassRepo-$User"

        $RepoName | Write-Verbose

        # $result = gh pr view 3 -R "$CLASS_ORG/conflict-practice-$User" --json title | convertfrom-json
        $result = gh repo view $RepoName *>&1
        $Exists = $?

        $result | write-verbose

        [PSCustomObject]@{
            User = $User
            Exists = $Exists
        }
    }
} Export-ModuleMember -Function Get-TeacherOfClassRepo

function Get-TeacherOfConflictPracticeRepo{
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory, Position=0, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$User,
        [Parameter(Mandatory)][string]$Owner
    )
    $repo = "{0}/conflict-practice-{1}" -f $Owner, $User

    $command = 'gh pr view 1 -R {0} --json author' -f $repo
    
    $result = Invoke-GhExpression $command -Whatif:$WhatIfPreference

    return $result

} Export-ModuleMember -Function Get-TeacherOfConflictPracticeRepo
