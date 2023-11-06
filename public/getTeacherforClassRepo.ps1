
function Get-TeacherOfConflictPracticeRepo{
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory, Position=0, ValueFromPipeline, ValueFromPipelineByPropertyName)] 
        [string]$User,
        [Parameter()][string]$Owner
    )

    process{

        $repo = Get-ActivityRepoName -User $User -Owner:$Owner -ActivityRepo 'conflict-practice'

        $command = 'gh pr view 1 -R {0} --json author' -f $repo

        $result = Invoke-GhExpression $command -Whatif:$WhatIfPreference

        $author = $result | Select-Object -ExpandProperty author

        $ret = $author | Select-Object -Property login,name

        return $ret
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

        $repo = Get-ActivityRepoName -user $User -Owner $Owner -ActivityRepo 'github-games'

        $command = 'gh issue view 1 -R {0} --json author' -f $repo

        $result = Invoke-GhExpression $command -Whatif:$WhatIfPreference

        $author = $result | Select-Object -ExpandProperty author

        $ret = $author | Select-Object -Property login,name

        return $ret

    }

} Export-ModuleMember -Function Get-TeacherOfGithubGameRepo
