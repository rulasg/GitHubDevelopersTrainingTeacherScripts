function Get-ClassRepo{
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)][string]$Name,
        [Parameter()][string]$Owner
   )

   process {

        $limit = 1000
        $attributes = "fullName,name"

        $owner = Resolve-Owner -Owner $Owner

        $command = 'gh search repos {reponame} in:name --owner {owner} --json {attributes}'
        $command = $command -replace "{reponame}",$Name
        $command = $command -replace "{owner}",$owner
        $command = $command -replace "{limt}",$limit
        $command = $command -replace "{attributes}",$attributes

        $result = Invoke-GhExpression $command

        $ret = $result

        return  $ret

   }

} Export-ModuleMember -Function Get-ClassRepo

function Remove-ClassRepo{
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory,ValueFromPipelineByPropertyName,ValueFromPipeline)][string]$Name,
        [Parameter()][string]$Owner
   )
    process{

        $repoName = Get-ClassRepoName -RepoName $Name -Owner $Owner
        
        if ($PSCmdlet.ShouldProcess($Name, "gh repo delete")) {
            gh repo delete $RepoName --yes
        }
    }
} Export-ModuleMember -Function Remove-ClassRepo