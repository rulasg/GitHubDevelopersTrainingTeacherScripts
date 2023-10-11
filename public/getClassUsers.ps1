function Get-ClassUsers{
    [CmdletBinding(SupportsShouldProcess)]
    param(
        # Target repo
        [Parameter(Mandatory,Position=0, ValueFromPipeline)][string]$RepoName,
        # Owner of the repo
        [Parameter()][string]$Owner
    )

    process {

        # $owner = Get-OwnerFromEnvironment -Owner $Owner
        $owner = Resolve-Owner -Owner $Owner

        $issueId = Find-FirstActivityIssue -RepoName $RepoName -Owner $owner
        
        $command = 'gh issue view {issueId} -R {owner}/{repo} --json body'
        $command = $command -replace '{issueId}', $issueId
        $command = $command -replace '{repo}', $RepoName
        $command = $command -replace '{owner}', $owner
        
        if ($PSCmdlet.ShouldProcess("Invoke-GhExpression", $command)) {
            $result = Invoke-GhExpression $command
        } else {
            Write-Information $command
            # Mock asnwer for testing
            $result = $null
        }
        
        if(!$result){
            return $null
        }

        $list = $result.body -split "`n" | Where-Object{$_[0] -eq '-'} | ForEach-Object{ ($_ -split '@')[1]}
        
        return $list
    }
} Export-ModuleMember -Function Get-ClassUsers

function Find-FirstActivityIssue{
    [CmdletBinding(SupportsShouldProcess)]
    param(
        # Target repo
        [Parameter(Mandatory, Position=0)][string]$RepoName,
        # Owner of the repo
        [Parameter()][string]$Owner
    )

    $ISSUE_TITLE = 'Activity 1: Your First Caption'

    $repoName = Get-ClassRepoName -RepoName $RepoName -Owner $Owner

    $command = 'gh issue list -R {repo} --json title,number -s all'

    $command = $command -replace '{repo}', $repoName

    if ($PSCmdlet.ShouldProcess("Invoke-GhExpression", $command)) {
        $result = Invoke-GhExpression $command
    } else {
        Write-Information $command
        # mock answer for testing
        $result = [PSCustomObject]@{
            title = $ISSUE_TITLE
            number = 1
        }
    }
    $issue = $result | Where-Object{$_.title -match $ISSUE_TITLE}

    #check if no issue found
    if($issue.count -eq 0){
        throw "No issue found with title $ISSUE_TITLE"
    }

    #check if more than 1 issue found
    if($issue.count -gt 1){
        throw "More than one issue found with title $ISSUE_TITLE"
    }

    return $issue.number
}