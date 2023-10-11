
<#
.SYNOPSIS
    This function checks if the ConflictPractice repo is created correctly for a given user.
.DESCRIPTION
    The repo has to have 3 PR. We will check if the PR number 3 is crated on the repo.
.EXAMPLE
    Test-ConflictPracticeRepo -User "AlexBimatics"
    User    Exists
    ----    ------
    AlexBimatics    True
.EXAMPLE
    Get-Users | Test-ConflictPracticeRepo
    User    Exists
    ----    ------
    AlexBimatics    True
    CebucRadu   True
    DoshiHimanshu   True
    GunjanRaman True
#>
function Test-ConflictPracticeRepoPR3{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position=0, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$User
    )

    process{

        $user | write-verbose

        $RepoName = "$CLASS_ORG/conflict-practice-$User"

        # $result = gh pr view 3 -R "$CLASS_ORG/conflict-practice-$User" --json title | convertfrom-json
        $result = gh pr view 3 -R $RepoName *>&1

        $result | write-verbose

        # $Exists = $result[0].StartsWith("title:  Update README")
        # check if $result is of type error
        $NotExists = $result.GetType().Name -eq 'ErrorRecord'

        [PSCustomObject]@{
            User = $User
            Repo = $RepoName
            Exists = -Not $NotExists
        }
    }
} Export-ModuleMember -Function Test-ConflictPracticeRepoPR3


