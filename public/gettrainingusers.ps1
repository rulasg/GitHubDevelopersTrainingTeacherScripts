function Get-ClassUsers{
    [CmdletBinding()]
    param(
        # Target repo
        [Parameter(Mandatory,Position=0, ValueFromPipeline)]
        [string]$ClassRepo
    )

    process {

        $issueId = Find-FirstActivityIssue -ClassRepo $ClassRepo
        
        $command = 'gh issue view {issueId}  -R ps-developers-sandbox/{repo} --json body | convertfrom-json'
        $command = $command -replace '{issueId}', $issueId
        $command = $command -replace '{repo}', $ClassRepo
        
        $result = Invoke-Expression $command
        
        $list = $result.body -split "`n" | Where-Object{$_[0] -eq '-'} | %{ ($_ -split '@')[1]}
        
        return $list
    }
} Export-ModuleMember -Function Get-ClassUsers

function Find-FirstActivityIssue{
    [CmdletBinding()]
    param(
        # Target repo
        [Parameter(Mandatory, Position=0)]
        [string]$ClassRepo
    )

    $ISSUE_TITLE = 'Activity 1: Your First Caption'

    $command = 'gh issue list -R ps-developers-sandbox/{repo} --json title,number -s all| convertfrom-json'

    $command = $command -replace '{repo}', $ClassRepo

    $result = Invoke-Expression $command

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