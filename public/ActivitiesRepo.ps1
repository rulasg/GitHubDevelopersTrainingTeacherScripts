
function Test-ActivityRepo{
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)][ValidateSet("conflict-practice", "github-games", "all")][string]$ActivityRepo,
        [Parameter(Mandatory,ValueFromPipeline)][string]$User,
        [Parameter()][string]$Owner
    )

    process{

        if($ActivityRepo -eq "all"){
            "conflict-practice", "github-games" | ForEach-Object {
                Test-ActivityRepo -ActivityRepo $_ -User $User -Owner $Owner
            }
            return
        }

        $repoName = Get-ActivityRepoName -User $User -Owner $Owner -ActivityRepo $ActivityRepo

        $repoName | Write-Verbose

        $result = gh repo view $RepoName *>&1
        $Exists = $?

        $result | write-verbose

        [PSCustomObject]@{
            User = $User
            Repo = $RepoName
            Exists = $Exists
        }
    }
} Export-ModuleMember -Function Test-ActivityRepo

function Remove-ActivityRepo{
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)][ValidateSet("conflict-practice", "github-games", "all")]
        [string]$ActivityRepo,
        [Parameter(Mandatory,ValueFromPipeline)][string]$User,
        [Parameter()][string]$Owner
    )

    process{

        if($ActivityRepo -eq "all"){
            "conflict-practice", "github-games" | ForEach-Object {
                Remove-ActivityRepo -ActivityRepo $_ -User $User -Owner $Owner
            }
            return
        }

        $repoName = Get-ActivityRepoName -User $User -Owner $Owner -ActivityRepo $ActivityRepo

        $RepoName | Write-Verbose

        if ($PSCmdlet.ShouldProcess($RepoName, "gh repo delete")) {
            gh repo delete $RepoName --yes
        }
    }
} Export-ModuleMember -Function Remove-ActivityRepo
