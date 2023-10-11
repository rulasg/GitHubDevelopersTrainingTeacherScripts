
function Test-ActivitiesRepo{
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)][ValidateSet("conflict-practice", "github-games")][string]$ActivityRepo,
        [Parameter(Mandatory,ValueFromPipeline)][string]$User,
        [Parameter()][string]$Owner
    )

    process{

        $repoName = Get-ActivityRepoName -User $User -Owner $Owner -ActivityRepo $ActivityRepo

        $repoName | Write-Verbose

        # $result = gh pr view 3 -R "$CLASS_ORG/conflict-practice-$User" --json title | convertfrom-json
        $result = gh repo view $RepoName *>&1
        $Exists = $?

        $result | write-verbose

        [PSCustomObject]@{
            User = $User
            Repo = $RepoName
            Exists = $Exists
        }
    }
} Export-ModuleMember -Function Test-ActivitiesRepo

function Remove-ActivityRepo{
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)][ValidateSet("conflict-practice", "github-games")][string]$ActivityRepo,
        [Parameter(Mandatory,ValueFromPipeline)][string]$User,
        [Parameter()][string]$Owner
    )

    process{

        $repoName = Get-ActivityRepoName -User $User -Owner $Owner -ActivityRepo $ActivityRepo

        $RepoName | Write-Verbose

        if ($PSCmdlet.ShouldProcess($RepoName, "gh repo delete")) {
            gh repo delete $RepoName --yes
            if(!$?){
                $repoURL = "https://$ROOT_URL/$RepoName"
                $repoURL | Write-Verbose
            }

        }
    }
} Export-ModuleMember -Function Remove-ActivityRepo
