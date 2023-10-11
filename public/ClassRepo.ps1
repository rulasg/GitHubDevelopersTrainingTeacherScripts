
function Test-ClassRepo{
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)]
        [ValidateSet("conflict-practice", "github-games")]
        [string]$ClassRepo,
        [Parameter(Mandatory, Position=0, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$User
    )

    process{

        $RepoName = "$CLASS_ORG/$ClassRepo-$User"

        $RepoName | Write-Verbose

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
} Export-ModuleMember -Function Test-ClassRepo

function Remove-ClassRepo{
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)]
        [ValidateSet("conflict-practice", "github-games")]
        [string]$ClassRepo,
        [Parameter(Mandatory, Position=0, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$User
    )

    process{

        $RepoName = "$CLASS_ORG/$ClassRepo-$User"

        $RepoName | Write-Verbose

        if ($PSCmdlet.ShouldProcess($RepoName, "gh repo delete")) {
            gh repo delete $RepoName --yes
            if(!$?){
                $repoURL = "https://$ROOT_URL/$RepoName"
                $repoURL | Write-Verbose
            }

        }
    }
} Export-ModuleMember -Function Remove-ClassRepo
